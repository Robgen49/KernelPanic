package com.oauth2.Kernel.panic.service.impl;

import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.repository.TeamRepository;
import com.oauth2.Kernel.panic.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService {

    private final TeamRepository teamRepository;

    @Override
    public UserDetailsService userDetailsService() {
        return username -> teamRepository.findByLogin(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

    public List<Team> findAll() {
        return teamRepository.findAll();
    }

    public Team findById(int id) {
        return teamRepository.findById(id).orElse(null);
    }

    public void update(Team updatedTeam) {
        teamRepository.save(updatedTeam);
    }

    public void delete(int id) {
        teamRepository.deleteById(id);
    }

    public Team findByLogin(String login) {
        return teamRepository.findByLogin(login).orElse(null);
    }

}
