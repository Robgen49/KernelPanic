package com.oauth2.Kernel.panic.controller;

import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/team")
@RequiredArgsConstructor
@CrossOrigin
@Tag(name = "team_controller")
public class TeamController {

    @GetMapping("/hello")
    public ResponseEntity<String> team() {
        return ResponseEntity.ok("Hi team");
    }
}
