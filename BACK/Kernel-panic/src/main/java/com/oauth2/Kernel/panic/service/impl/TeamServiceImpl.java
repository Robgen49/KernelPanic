package com.oauth2.Kernel.panic.service.impl;

import com.oauth2.Kernel.panic.repository.TeamRepository;
import com.oauth2.Kernel.panic.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService {

    private final TeamRepository teamRepository;

    @Override
    public UserDetailsService userDetailsService() {
        return username -> teamRepository.findByLogin(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

}
