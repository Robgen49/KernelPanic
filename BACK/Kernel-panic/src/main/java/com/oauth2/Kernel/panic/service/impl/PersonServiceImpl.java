package com.oauth2.Kernel.panic.service.impl;

import com.oauth2.Kernel.panic.entity.Person;
import com.oauth2.Kernel.panic.repository.PersonRepository;
import com.oauth2.Kernel.panic.service.PersonService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PersonServiceImpl implements PersonService {

    private final PersonRepository personRepository;

    public void save(Person person) {
        personRepository.save(person);
    }

    @Override
    public void saveAll(List<Person> teammates) {
        personRepository.saveAll(teammates);
    }

    public List<Person> findAll() {
        return personRepository.findAll();
    }

    public Person findById(int id) {
        return personRepository.findById(id).orElse(null);
    }


}
