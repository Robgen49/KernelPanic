package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.dto.JwtAuthenticationResponse;
import com.oauth2.Kernel.panic.dto.RefreshTokenRequest;
import com.oauth2.Kernel.panic.dto.SignUpRequest;
import com.oauth2.Kernel.panic.dto.SigninRequest;
import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.service.AuthenticationService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
@CrossOrigin
@Tag(name = "Auth_Controller")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping("/signup")
    public ResponseEntity<Team> signup(@RequestBody SignUpRequest signUpRequest) {
        return ResponseEntity.ok(authenticationService.signup(signUpRequest));
    }

    @PostMapping("/signin")
    public ResponseEntity<JwtAuthenticationResponse> signin(@RequestBody SigninRequest signinRequest) {
        return ResponseEntity.ok(authenticationService.signin(signinRequest));
    }

    @PostMapping("/refresh")
    public ResponseEntity<JwtAuthenticationResponse> refresh(@RequestBody RefreshTokenRequest refreshTokenRequest) {
        return ResponseEntity.ok(authenticationService.refreshToken(refreshTokenRequest));
    }
}
