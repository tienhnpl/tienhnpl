package com.example.ecommerce_logs.service;

import java.time.Instant;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.stereotype.Service;

import com.example.ecommerce_logs.config.RabbitConfig;
import com.example.ecommerce_logs.dto.LogMessage;
import com.example.ecommerce_logs.dto.OrderRequest;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class OrderService {
    private final RabbitTemplate rabbit;
    private final ObjectMapper mapper;
    private final Logger logger = LoggerFactory.getLogger(getClass());

    public OrderService(RabbitTemplate rabbit, ObjectMapper mapper) {
        this.rabbit = rabbit;
        this.mapper = mapper;
    }

    public Map<String, Object> processOrder(OrderRequest req) {
        String orderId = UUID.randomUUID().toString();
        double total = req.getItems().stream()
                .mapToDouble(i -> i.getPrice() * i.getQuantity())
                .sum();

        boolean success = true;
        String infoMsg = String.format(
                "Order created successfully. Order ID: %s, Customer ID: %d, Total amount: %.2f",
                orderId, req.getCustomerId(), total);

        String errorReason = null;
        if (!"creditCard".equals(req.getPaymentMethod())
                || req.getCreditCardNumber() == null
                || req.getCreditCardNumber().replaceAll("\\D", "").length() != 16) {
            success = false;
            errorReason = "Invalid paymentMethod or creditCardNumber must be 16 digits";
        }

        LogMessage log = new LogMessage();
        log.setTimestamp(Instant.now());
        if (success) {
            log.setLevel("INFO");
            log.setMessage(infoMsg);
            logger.info(infoMsg);
        } else {
            log.setLevel("ERROR");
            String msg = String.format(
                    "Payment failed for order ID: %s. Reason: %s", orderId, errorReason);
            log.setMessage(msg);
            logger.error(msg);
        }

        try {
            String payload = mapper.writeValueAsString(log);
            rabbit.convertAndSend(RabbitConfig.EXCHANGE, "", payload);
        } catch (JsonProcessingException e) {
            logger.error("Cannot serialize log message", e);
        }

        return Map.of(
                "orderId", orderId,
                "totalAmount", total,
                "status", success ? "CREATED" : "FAILED");
    }
}
