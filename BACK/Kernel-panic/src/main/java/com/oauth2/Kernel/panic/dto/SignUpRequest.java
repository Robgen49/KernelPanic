package com.oauth2.Kernel.panic.dto;

import com.oauth2.Kernel.panic.entity.Person;
import jakarta.persistence.OneToMany;
import lombok.Data;
import java.util.List;

@Data
public class SignUpRequest {
    private String teamName;
    private String logo;
    private String email;
    private String login;
    private String password;
    private List<Person> teammates;
}
