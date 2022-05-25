package com.salesianos.dam.BlocPosty.users.dto;

import com.salesianos.dam.BlocPosty.users.model.UserType;
import com.salesianos.dam.BlocPosty.validation.multiple.MatchingPasswords;
import com.salesianos.dam.BlocPosty.validation.simple.UniqueUsername;
import lombok.*;
import com.salesianos.dam.BlocPosty.users.model.UserProfile;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter @Setter
@MatchingPasswords.List(
        @MatchingPasswords(
                password = "password",
                passwordMatch = "password2",
                message = "Las contraseñas no coinciden"
        )
)
public class CreateUserDto {

    @UniqueUsername
    private String username;

    @NotBlank
    @Email
    private String email;

    private String telefono;

    private UserProfile perfil;

    private UserType permisos;

    @NotBlank
    private String password;

    @NotBlank
    private String password2;
}
