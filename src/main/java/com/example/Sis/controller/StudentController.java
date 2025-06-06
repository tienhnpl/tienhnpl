package com.example.Sis.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.Sis.entity.Student;
import com.example.Sis.entity.StudentScore;
import com.example.Sis.repository.StudentRepository;
import com.example.Sis.repository.StudentScoreRepository;
import com.example.Sis.repository.SubjectRepository;

@Controller
public class StudentController {

    @Autowired
    private StudentRepository studentRepo;
    @Autowired
    private SubjectRepository subjectRepo;
    @Autowired
    private StudentScoreRepository scoreRepo;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("scores", scoreRepo.findAll());
        return "index";
    }

    @GetMapping("/student/new")
    public String newStudent(Model model) {
        model.addAttribute("student", new Student());
        return "add-student";
    }

    @PostMapping("/student/save")
    public String saveStudent(@ModelAttribute Student student) {
        studentRepo.save(student);
        return "redirect:/";
    }

    @GetMapping("/score/new")
    public String newScore(Model model) {
        model.addAttribute("students", studentRepo.findAll());
        model.addAttribute("subjects", subjectRepo.findAll());
        model.addAttribute("score", new StudentScore());
        return "add-score";
    }

    @PostMapping("/score/save")
    public String saveScore(@ModelAttribute StudentScore score) {
        scoreRepo.save(score);
        return "redirect:/";
    }

}
