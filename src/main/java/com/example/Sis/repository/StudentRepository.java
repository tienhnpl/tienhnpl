package com.example.Sis.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.Sis.entity.Student;

public interface StudentRepository extends JpaRepository<Student, Integer> {
}
