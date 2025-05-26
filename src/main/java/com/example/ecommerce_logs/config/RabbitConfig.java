package com.example.ecommerce_logs.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.FanoutExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {
    public static final String EXCHANGE = "logs-exchange";
    public static final String QUEUE = "logs-queue";

    @Bean
    public FanoutExchange fanoutExchange() {
        return new FanoutExchange(EXCHANGE);
    }

    @Bean
    public Queue logQueue() {
        return new Queue(QUEUE, true);
    }

    @Bean
    public Binding binding(Queue logQueue, FanoutExchange fanoutExchange) {
        return BindingBuilder.bind(logQueue).to(fanoutExchange);
    }
}
