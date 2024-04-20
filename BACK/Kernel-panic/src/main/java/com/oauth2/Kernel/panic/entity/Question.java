package com.oauth2.Kernel.panic.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "question")
@Data
public class Question {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String full_name;
    private String email;
    private String question;

    @ManyToOne
    @JoinColumn(name = "person_id", referencedColumnName = "id")
    @JsonBackReference
    private Person person;
}
