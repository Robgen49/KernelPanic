package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.service.TeamService;
import com.oauth2.Kernel.panic.service.impl.TeamServiceImpl;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/team")
@RequiredArgsConstructor
@CrossOrigin
@Tag(name = "team_controller")
public class TeamController {

    private final TeamService teamService;

    @GetMapping("/hello")
    public ResponseEntity<String> team() {
        return ResponseEntity.ok("Hi team");
    }

    @GetMapping("/findAll")
    public List<Team> findAll() {
        return teamService.findAll();
    }

    @GetMapping("/findById")
    public Team findById(@RequestParam int id) {
        return teamService.findById(id);
    }
}
