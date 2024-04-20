package com.oauth2.Kernel.panic.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "person")
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String full_name;
    private String photo;
    @ManyToOne
    @JoinColumn(name = "team_id", referencedColumnName = "id")
    @JsonBackReference
    private Team team;
    private String stack_tech;
    private String direction;
    private String assessment;
    private String difficulties;
}
