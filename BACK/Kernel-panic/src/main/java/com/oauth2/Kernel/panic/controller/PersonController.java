package com.oauth2.Kernel.panic.controller;

import com.oauth2.Kernel.panic.entity.Person;
import com.oauth2.Kernel.panic.entity.Team;
import com.oauth2.Kernel.panic.service.PersonService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/person")
@Tag(name = "person_controller")
@CrossOrigin(maxAge = 3600L)
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

    @PatchMapping("/update")
    public ResponseEntity<Person> update(@RequestBody Person updatedPerson) {
        Person existingPerson = personService.findById(updatedPerson.getId());
        if (existingPerson == null) {
            return ResponseEntity.notFound().build();
        }

        BeanUtils.copyProperties(updatedPerson, existingPerson, getNullPropertyNames(updatedPerson));

        Person updatedEntity = personService.update(existingPerson);

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
