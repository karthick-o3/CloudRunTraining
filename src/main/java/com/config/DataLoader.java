package com.config;

import com.model.Question;
import com.repository.QuestionRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {

    @Bean
    public CommandLineRunner loadData(QuestionRepository questionRepository) {
        return args -> {
            questionRepository.save(new Question(null, "What is Java?", "Java is a programming language."));
            questionRepository.save(new Question(null, "What is Spring Boot?", "Spring Boot is a framework for building Java applications."));
            questionRepository.save(new Question(null, "What is REST?", "REST is an architectural style for building APIs."));
        };
    }
}