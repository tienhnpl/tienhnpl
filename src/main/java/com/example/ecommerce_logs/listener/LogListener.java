package com.example.ecommerce_logs.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;

import com.example.ecommerce_logs.config.RabbitConfig;
import com.example.ecommerce_logs.dto.LogMessage;
import com.example.ecommerce_logs.model.LogEntity;
import com.example.ecommerce_logs.repository.LogRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class LogListener {
    private final LogRepository repo;
    private final ObjectMapper mapper;
    private final Logger logger = LoggerFactory.getLogger(getClass());

    public LogListener(LogRepository repo, ObjectMapper mapper) {
        this.repo = repo;
        this.mapper = mapper;
    }

    @RabbitListener(queues = RabbitConfig.QUEUE)
    public void onMessage(String payload) {
        try {
            LogMessage log = mapper.readValue(payload, LogMessage.class);

            LogEntity e = new LogEntity();
            e.setLevel(log.getLevel());
            e.setMessage(log.getMessage());
            e.setTimestamp(log.getTimestamp());
            e.setServiceName(log.getServiceName());
            repo.save(e);

            if ("ERROR".equals(log.getLevel())) {
                logger.error(
                        "Error log detected. Sending notification to tech team: {}",
                        log.getMessage());
            }
        } catch (JsonProcessingException ex) {
            logger.error("Invalid log payload", ex);
        }
    }
}
