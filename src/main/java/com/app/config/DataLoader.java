package com.app.config;

import com.app.model.Question;
import com.app.repository.QuestionRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class DataLoader {

    @Bean
    public CommandLineRunner loadData(QuestionRepository questionRepository) {
        return args -> {
            questionRepository.save(new Question(null, "Is Java a compiled language?", "true"));
            questionRepository.save(new Question(null, "Is Spring Boot a framework?", "true"));
            questionRepository.save(new Question(null, "Is REST an architectural style?", "true"));
            questionRepository.save(new Question(null, "Is Python a statically typed language?", "false"));
            questionRepository.save(new Question(null, "Is HTML a programming language?", "false"));
//            questionRepository.save(new Question(null, "Is Kubernetes used for container orchestration?", "true"));
//            questionRepository.save(new Question(null, "Is Git a version control system?", "true"));
//            questionRepository.save(new Question(null, "Is JavaScript the same as Java?", "false"));
//            questionRepository.save(new Question(null, "Is Docker used for virtualization?", "false"));
//            questionRepository.save(new Question(null, "Is SQL a programming language?", "false"));
//            questionRepository.save(new Question(null, "Is Linux an operating system?", "true"));
//            questionRepository.save(new Question(null, "Is JSON a markup language?", "false"));
//            questionRepository.save(new Question(null, "Is CSS used for styling web pages?", "true"));
//            questionRepository.save(new Question(null, "Is C++ an object-oriented programming language?", "true"));
//            questionRepository.save(new Question(null, "Is React a backend framework?", "false"));
//            questionRepository.save(new Question(null, "Is Node.js a runtime environment for JavaScript?", "true"));
//            questionRepository.save(new Question(null, "Is MySQL a NoSQL database?", "false"));
//            questionRepository.save(new Question(null, "Is TypeScript a superset of JavaScript?", "true"));
//            questionRepository.save(new Question(null, "Is MongoDB a relational database?", "false"));
//            questionRepository.save(new Question(null, "Is HTTPS more secure than HTTP?", "true"));
        };
    }
}