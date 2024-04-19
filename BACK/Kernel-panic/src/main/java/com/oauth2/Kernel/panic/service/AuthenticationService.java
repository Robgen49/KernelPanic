package com.oauth2.Kernel.panic.service;

import com.oauth2.Kernel.panic.dto.JwtAuthenticationResponse;
import com.oauth2.Kernel.panic.dto.RefreshTokenRequest;
import com.oauth2.Kernel.panic.dto.SignUpRequest;
import com.oauth2.Kernel.panic.dto.SigninRequest;
import com.oauth2.Kernel.panic.entity.Team;

public interface AuthenticationService {
    Team signup(SignUpRequest signUpRequest);
    JwtAuthenticationResponse signin(SigninRequest signinRequest);
    JwtAuthenticationResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}
