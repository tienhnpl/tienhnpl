package com.example.ecommerce_logs.dto;

import java.util.List;

import lombok.Data;

@Data
public class OrderRequest {
    private Long customerId;
    private List<Item> items;
    private String paymentMethod;
    private String creditCardNumber;
}
