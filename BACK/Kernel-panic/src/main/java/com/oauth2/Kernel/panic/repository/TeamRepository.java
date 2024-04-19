package com.oauth2.Kernel.panic.repository;

import com.oauth2.Kernel.panic.entity.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TeamRepository extends JpaRepository<Team,Integer> {
    Optional<Team> findByLogin(String login);
}
