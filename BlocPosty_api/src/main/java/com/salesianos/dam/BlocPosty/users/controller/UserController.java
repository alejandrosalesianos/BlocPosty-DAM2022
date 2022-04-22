package com.salesianos.dam.BlocPosty.users.controller;

import com.salesianos.dam.BlocPosty.users.dto.CreateUserDto;
import com.salesianos.dam.BlocPosty.users.dto.GetUserDto;
import com.salesianos.dam.BlocPosty.users.dto.UserDtoConverter;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.model.UserProfile;
import com.salesianos.dam.BlocPosty.users.model.UserType;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URI;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth/register")
public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter dtoConverter;

    @PostMapping("/")
    public ResponseEntity<GetUserDto> newUser (@RequestPart("user") CreateUserDto createUserDto, @RequestPart("file") MultipartFile file) throws IOException {

        UserEntity user = userEntityService.saveUser(createUserDto,file);
        GetUserDto getUserDto = dtoConverter.UserEntityToGetUserDto(user);
        return ResponseEntity.created(URI.create(user.getFotoPerfil())).body(getUserDto);
    }
}
