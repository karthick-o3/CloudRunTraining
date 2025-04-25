terraform {
  backend "gcs" {
    bucket = "karthick-state-store"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.90.0"
    }
  }
}

provider "google" {
    project = var.project_id
    region  = "us-central1"
}

data "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = var.registry_repo_name
}

resource "null_resource" "data_dependency" {
  triggers = {
    repository_id = data.google_artifact_registry_repository.docker_repo.repository_id
  }
}

#resource "google_artifact_registry_repository" "docker_repo" {
##  provider      = google
##  location      = var.region
#  repository_id = var.registry_repo_name
#  format        = "DOCKER"
#}

resource "null_resource" "build_and_push_image" {
  triggers = {
    script_version = sha256(file("./Dockerfile"))                                  # Detects changes in Dockerfile
    config_version = sha256(join("", [var.project_id, var.registry_repo_name, var.image_name])) # Detects variable changes
    always_run     = "${timestamp()}"                                                  # Forces re-execution on every terraform apply
  }

  provisioner "local-exec" {
    command = <<EOT
      gcloud auth configure-docker ${var.region}-docker.pkg.dev

      # Build the Docker image using your existing Dockerfile
      docker build \
      --debug \
      -f Dockerfile \
      --platform linux/amd64 \
      --progress=plain \
      -t ${var.region}-docker.pkg.dev/${var.project_id}/${var.registry_repo_name}/${var.image_name}:${var.tag_version} \
      ../../

      # Push the image to Google Artifact Registry
      docker push ${var.region}-docker.pkg.dev/${var.project_id}/${var.registry_repo_name}/${var.image_name}:${var.tag_version}
    EOT
  }

  depends_on = [null_resource.data_dependency]
}



resource "google_cloud_run_v2_service" "default" {
  name     = var.service_name
  location = var.region
  deletion_protection = false
  template {

    containers {
      image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.registry_repo_name}/${var.image_name}:${var.tag_version}"

      # Convert environment variables map to a list of { name, value } objects
      dynamic "env" {
        for_each = var.env_vars
        content {
          name  = env.key
          value = env.value
        }
      }

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }

  traffic {
    percent = 100
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
  }

  depends_on = [null_resource.build_and_push_image]
}


resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.default.location
  service  = google_cloud_run_v2_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
  depends_on = [google_cloud_run_v2_service.default]
}

output "cloud_run_service_url" {
  value = google_cloud_run_v2_service.default.uri
  description = "The URL of the deployed Cloud Run service."
}
output "cloud_run_service_create_time" {
  value = google_cloud_run_v2_service.default.create_time
  description = "The URL of the deployed Cloud Run service."
}
#import {
#  id = "projects/cloudrun-workshop-2025/locations/us-central1/services/karthick-aw"
#  to = google_cloud_run_v2_service.default
#}
