package com.oauth2.Kernel.panic.service;

import com.oauth2.Kernel.panic.entity.Person;

import java.util.List;

public interface PersonService {

     void save(Person person);

     void saveAll(List<Person> teammates);

     Person findById(int id);
     List<Person> findAll();
     Person update(Person updatedPerson);
}
