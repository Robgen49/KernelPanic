package com.oauth2.Kernel.panic.dto;

import com.oauth2.Kernel.panic.entity.Team;
import lombok.Data;

@Data
public class PersonDTO {
    private String full_name;
    private String email;
    private String photo;
    private String about_me;
    private Team team;
}
