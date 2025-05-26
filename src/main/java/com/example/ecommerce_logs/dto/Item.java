package com.example.ecommerce_logs.dto;

import lombok.Data;

@Data
public class Item {
    private Long productId;
    private Integer quantity;
    private Double price;
}
