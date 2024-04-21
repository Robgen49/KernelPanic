package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.service.TeamService;
import com.oauth2.Kernel.panic.service.impl.TeamServiceImpl;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@RestController
@RequestMapping("/api/team")
@RequiredArgsConstructor
@Tag(name = "team_controller")
@CrossOrigin(maxAge = 3600L)
public class TeamController {

    private final TeamService teamService;

    @GetMapping("/hello")
    public ResponseEntity<String> team() {
        return ResponseEntity.ok("Hi team");
    }

    @GetMapping("/findAll")
    public ResponseEntity<List<Team>> findAll() {
        return ResponseEntity.ok(teamService.findAll());
    }

    @GetMapping("/findById")
    public ResponseEntity<Team> findById(@RequestParam int id) {
        return ResponseEntity.ok(teamService.findById(id));
    }

    @GetMapping("/currentTeam")
    public ResponseEntity<Team> getCurrentTeam() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String teamLogin = authentication.getName();
        Team currentTeam = teamService.findByLogin(teamLogin);
        if (currentTeam != null) {
            return ResponseEntity.ok(currentTeam);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PatchMapping("/update")
    public ResponseEntity<Team> update(@RequestBody Team updatedTeam) {
        // Получаем существующий объект Team из базы данных по его идентификатору
        Team existingTeam = teamService.findById(updatedTeam.getId());
        if (existingTeam == null) {
            return ResponseEntity.notFound().build();
        }

        BeanUtils.copyProperties(updatedTeam, existingTeam, getNullPropertyNames(updatedTeam));

        Team updatedEntity = teamService.update(existingTeam);

        return ResponseEntity.ok(updatedEntity);
    }

    private String[] getNullPropertyNames(Object source) {
        final BeanWrapper src = new BeanWrapperImpl(source);
        java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();
        Set<String> emptyNames = new HashSet<>();
        for(java.beans.PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) emptyNames.add(pd.getName());
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }
}
