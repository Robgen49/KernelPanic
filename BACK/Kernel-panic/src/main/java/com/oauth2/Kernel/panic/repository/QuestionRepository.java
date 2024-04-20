package com.oauth2.Kernel.panic.repository;

import com.oauth2.Kernel.panic.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface QuestionRepository extends JpaRepository<Question,Integer> {
}
