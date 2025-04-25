variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default = "cloudrun-workshop-2025"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "registry_repo_name" {
  description = "The name of the Artifact Registry repository"
  type        = string
  default     = "docker-images"
}

variable "image_name" {
  description = "The name of the Docker image"
  type        = string
  default     = "karthick-aw"
}

variable "dockerfile_path" {
  default = "Dockerfile"
}
#variable "build_context" {
#  default = ""
#}

variable "tag_version" {
  type = string
  default = "v2"
}

variable "service_name" {
  description = "The Cloud Run service name"
  type        = string
  default     = "karthick-aw"
}

variable "env_vars" {
  type        = map(string)
  description = "Environment variables to be passed to the Cloud Run container"
  default     = {}
}