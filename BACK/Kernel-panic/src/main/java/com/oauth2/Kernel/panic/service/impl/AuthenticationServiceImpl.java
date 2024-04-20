package com.oauth2.Kernel.panic.service.impl;

import com.oauth2.Kernel.panic.dto.JwtAuthenticationResponse;
import com.oauth2.Kernel.panic.dto.RefreshTokenRequest;
import com.oauth2.Kernel.panic.dto.SignUpRequest;
import com.oauth2.Kernel.panic.dto.SigninRequest;
import com.oauth2.Kernel.panic.entity.Person;
import com.oauth2.Kernel.panic.entity.Role;
import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.repository.PersonRepository;
import com.oauth2.Kernel.panic.repository.TeamRepository;
import com.oauth2.Kernel.panic.service.AuthenticationService;
import com.oauth2.Kernel.panic.service.JWTService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AuthenticationServiceImpl implements AuthenticationService {

    private final TeamRepository teamRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JWTService jwtService;
    private final PersonRepository personRepository;

    public Team signup(SignUpRequest signUpRequest) {
        Team team = new Team();
        team.setTeamName(signUpRequest.getTeamName());
        team.setLogo(signUpRequest.getLogo());
        team.setLogin(signUpRequest.getLogin());
        team.setEmail(signUpRequest.getEmail());
        team.setTeammates(signUpRequest.getTeammates());
        team.setRole(Role.TEAM);
        team.setPassword(passwordEncoder.encode(signUpRequest.getPassword()));
        return teamRepository.save(team);
    }

    public JwtAuthenticationResponse signin(SigninRequest signinRequest) {
        authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(signinRequest.getLogin(),
                signinRequest.getPassword()));

        var team = teamRepository.findByLogin(signinRequest.getLogin()).orElseThrow(()
                -> new IllegalArgumentException("Invalid login or password."));

        var jwt = jwtService.generateToken(team);
        var refreshToken = jwtService.generateRefreshToken(new HashMap<>(),team);

        JwtAuthenticationResponse jwtAuthenticationResponse = new JwtAuthenticationResponse();

        jwtAuthenticationResponse.setToken(jwt);
        jwtAuthenticationResponse.setRefreshToken(refreshToken);
        return jwtAuthenticationResponse;
    }

    public JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {
        String login = jwtService.extractUsername(refreshTokenRequest.getToken());
        Team team = teamRepository.findByLogin(login).orElseThrow();
        if(jwtService.isTokenValid(refreshTokenRequest.getToken(), team)) {
            var jwt = jwtService.generateToken(team);

            JwtAuthenticationResponse jwtAuthenticationResponse = new JwtAuthenticationResponse();

            jwtAuthenticationResponse.setToken(jwt);
            jwtAuthenticationResponse.setRefreshToken(refreshTokenRequest.getToken());
            return jwtAuthenticationResponse;
        }
        return null;
    }

}
