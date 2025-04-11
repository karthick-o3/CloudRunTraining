package com.cloudrun;

import com.api.QuestionEndpoint;
import com.repository.QuestionRepository;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScans;
import org.springframework.web.servlet.mvc.method.RequestMappingInfoHandlerMapping;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@SpringBootApplication
@ConfigurationPropertiesScan
@ComponentScan(basePackageClasses = {QuestionEndpoint.class, QuestionRepository.class})
public class CloudRunApplication {

	public static void main(String[] args) {
		SpringApplication.run(CloudRunApplication.class, args);

	}

}