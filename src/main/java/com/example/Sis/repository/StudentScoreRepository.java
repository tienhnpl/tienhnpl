package com.example.Sis.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.Sis.entity.StudentScore;

public interface StudentScoreRepository extends JpaRepository<StudentScore, Integer> {
}
