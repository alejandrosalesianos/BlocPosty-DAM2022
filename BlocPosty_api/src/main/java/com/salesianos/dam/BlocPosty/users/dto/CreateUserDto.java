package com.salesianos.dam.BlocPosty.users.dto;

import com.salesianos.dam.BlocPosty.users.model.UserType;
import lombok.*;
import com.salesianos.dam.BlocPosty.users.model.UserProfile;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter @Setter
public class CreateUserDto {

    private String username;

    private String email;

    private String telefono;

    private UserProfile perfil;

    private UserType permisos;

    private String password;

    private String password2;
}
