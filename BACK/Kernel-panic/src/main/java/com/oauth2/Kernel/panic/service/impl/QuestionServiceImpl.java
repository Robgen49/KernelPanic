package com.oauth2.Kernel.panic.service.impl;

import com.oauth2.Kernel.panic.entity.Question;
import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.repository.QuestionRepository;
import com.oauth2.Kernel.panic.service.QuestionService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class QuestionServiceImpl implements QuestionService {

    private final QuestionRepository questionRepository;

    public List<Question> findAll() {
        return questionRepository.findAll();
    }

    public Question findById(int id) {
        return questionRepository.findById(id).orElse(null);
    }

    public Question save(Question question) {
        return questionRepository.save(question);
    }
}
