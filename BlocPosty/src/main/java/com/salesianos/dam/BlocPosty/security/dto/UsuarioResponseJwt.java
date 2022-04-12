package com.salesianos.dam.BlocPosty.security.dto;


import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor @AllArgsConstructor

public class UsuarioResponseJwt {

    private String email;
    private String username;
    private String avatar;
    private String perfil;
    private String role;
    private String token;

}
