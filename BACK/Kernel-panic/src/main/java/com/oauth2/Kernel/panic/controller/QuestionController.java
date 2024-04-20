package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.entity.Question;
import com.oauth2.Kernel.panic.service.QuestionService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/question")
@Tag(name = "question_controller")
@CrossOrigin(maxAge = 3600L)
public class QuestionController {

    private final QuestionService questionService;
    @PostMapping("/post")
    public ResponseEntity<Question> postQuestion(@RequestBody Question question) {
        return ResponseEntity.ok(questionService.save(question));
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<Question>> findAll() {
        return ResponseEntity.ok(questionService.findAll());
    }

    @GetMapping("/findById")
    public ResponseEntity<Question> findById(@RequestParam int id) {
        return ResponseEntity.ok(questionService.findById(id));
    }
}
