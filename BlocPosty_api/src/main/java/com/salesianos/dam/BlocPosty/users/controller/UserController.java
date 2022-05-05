package com.salesianos.dam.BlocPosty.users.controller;

import com.salesianos.dam.BlocPosty.error.exception.EditException;
import com.salesianos.dam.BlocPosty.users.dto.CreateUserDto;
import com.salesianos.dam.BlocPosty.users.dto.GetUserDto;
import com.salesianos.dam.BlocPosty.users.dto.UserDtoConverter;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.model.UserProfile;
import com.salesianos.dam.BlocPosty.users.model.UserType;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.URI;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequiredArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserEntityService userEntityService;
    private final UserDtoConverter dtoConverter;

    @PostMapping("/auth/register")
    public ResponseEntity<GetUserDto> newUser (@RequestPart("user") CreateUserDto createUserDto, @RequestPart("file") MultipartFile file) throws IOException {

        UserEntity user = userEntityService.saveUser(createUserDto,file);
        GetUserDto getUserDto = dtoConverter.UserEntityToGetUserDto(user);
        return ResponseEntity.created(URI.create(user.getFotoPerfil())).body(getUserDto);
    }

    @PutMapping("/{id}")
    public ResponseEntity<GetUserDto> editUser (@RequestPart("user") CreateUserDto createUserDto, @RequestPart("file") MultipartFile file, @AuthenticationPrincipal UserEntity user, @PathVariable UUID id) throws EditException, Exception {
        Optional<UserEntity> userEntity = userEntityService.findById(id);

        if (!userEntity.isPresent()){
            return ResponseEntity.notFound().build();
        }
        if (!user.getId().equals(id)){
            throw new EditException();
        }
        else{
            UserEntity newUser = userEntityService.edit(id,createUserDto,file,user);
            GetUserDto getUserDto = dtoConverter.UserEntityToGetUserDto(newUser);
            return ResponseEntity.ok().body(getUserDto);
        }
    }
}
