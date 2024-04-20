package com.oauth2.Kernel.panic.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Data
@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String full_name;
    @Column(length = 20000)
    private String photo;
    @ManyToOne
    @JoinColumn(name = "team_id", referencedColumnName = "id")
    @JsonBackReference
    private Team team;
    private String stack_tech;
    private String direction;
    private String assessment;
    private String difficulties;

    @OneToMany(mappedBy = "person")
    @JsonManagedReference
    private List<Question> questions;
}
