package com.example.ecommerce_logs.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.ecommerce_logs.model.LogEntity;

public interface LogRepository extends JpaRepository<LogEntity, Long> {
}
