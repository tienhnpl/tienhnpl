package com.example.ecommerce_logs.dto;

import java.time.Instant;

import lombok.Data;

@Data
public class LogMessage {
    private String level;
    private String message;
    private Instant timestamp;
    private String serviceName = "ecommerce-logs";
}
