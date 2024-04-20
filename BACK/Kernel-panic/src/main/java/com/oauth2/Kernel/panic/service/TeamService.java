package com.oauth2.Kernel.panic.service;

import com.oauth2.Kernel.panic.entity.Team;
import org.springframework.security.core.userdetails.UserDetailsService;

import java.util.List;

public interface TeamService {
    UserDetailsService userDetailsService();
    List<Team> findAll();
    Team findById(int id);

    Team update(Team updatedTeam);
    void delete(int id);
    Team findByLogin(String login);
}
