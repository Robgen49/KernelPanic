package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.entity.Person;
import com.oauth2.Kernel.panic.service.PersonService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/person")
@CrossOrigin
@Tag(name = "person_controller")
public class PersonController {

    private final PersonService personService;

    @GetMapping("/findAll")
    public ResponseEntity<List<Person>> findAll() {
        return ResponseEntity.ok(personService.findAll());
    }

    @GetMapping("/findById")
    public ResponseEntity<Person> findById(@RequestParam int id) {
        return ResponseEntity.ok(personService.findById(id));
    }

    @PutMapping("/update")
    public ResponseEntity<Person> update(@RequestBody Person updatedPerson) {
        return ResponseEntity.ok(personService.update(updatedPerson));
    }
}
