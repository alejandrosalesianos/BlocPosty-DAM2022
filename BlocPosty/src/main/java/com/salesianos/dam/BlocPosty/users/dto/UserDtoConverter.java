package com.salesianos.dam.BlocPosty.users.dto;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {

    public GetUserDto UserEntityToGetUserDto(UserEntity user){

        return GetUserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .telefono(user.getTelefono())
                .avatar(user.getFotoPerfil())
                .perfil(user.getPerfil().name())
                .rol(user.getRol().name())
                .build();
    }
}
