package com.example.Sis.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "student_score")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer studentScoreId;

    @ManyToOne
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne
    @JoinColumn(name = "subject_id", nullable = false)
    private Subject subject;

    private double score1;
    private double score2;

    public double getFinalScore() {
        return 0.3 * score1 + 0.7 * score2;
    }

    public String getGrade() {
        double finalScore = getFinalScore();
        if (finalScore >= 8.0)
            return "A";
        if (finalScore >= 6.0)
            return "B";
        if (finalScore >= 4.0)
            return "D";
        return "F";
    }
}
