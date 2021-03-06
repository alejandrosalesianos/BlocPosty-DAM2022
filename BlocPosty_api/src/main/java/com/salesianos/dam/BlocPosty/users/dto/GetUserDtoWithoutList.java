package com.salesianos.dam.BlocPosty.users.dto;

import lombok.*;

import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class GetUserDtoWithoutList {

    private UUID id;
    private String username;
    private String email;
    private String telefono;
    private String perfil;
    private String rol;
    private String avatar;

}
