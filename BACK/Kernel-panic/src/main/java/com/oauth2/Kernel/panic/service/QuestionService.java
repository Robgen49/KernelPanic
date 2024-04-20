package com.oauth2.Kernel.panic.service;

import com.oauth2.Kernel.panic.entity.Question;

import java.util.List;

public interface QuestionService {

    List<Question> findAll();
    Question findById(int id);

    Question save(Question question);
}
