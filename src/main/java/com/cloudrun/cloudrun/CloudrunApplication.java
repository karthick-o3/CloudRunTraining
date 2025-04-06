package com.cloudrun.cloudrun;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.api", "com.cloudrun"})
public class CloudrunApplication {

	public static void main(String[] args) {
		SpringApplication.run(CloudrunApplication.class, args);
	}

}
