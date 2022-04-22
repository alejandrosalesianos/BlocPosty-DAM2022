package com.salesianos.dam.BlocPosty.security.dto;

import lombok.*;

@Getter @Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LoginDto {

    private String username;
    private String password;
}
