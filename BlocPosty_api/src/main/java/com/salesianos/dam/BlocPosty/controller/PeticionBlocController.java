package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.error.exception.NotFollowingException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.CreatePeticionDto;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.GetPeticionDto;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.PeticionDtoConverter;
import com.salesianos.dam.BlocPosty.services.impl.BlocService;
import com.salesianos.dam.BlocPosty.services.impl.PeticionBlocService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/peticion")
public class PeticionBlocController {

    private final PeticionDtoConverter peticionDtoConverter;
    private final PeticionBlocService peticionBlocService;
    private final UserEntityService userEntityService;
    private final BlocService blocService;

    @PostMapping("/{id}")
    public ResponseEntity<GetPeticionDto> postPeticion(@RequestBody CreatePeticionDto createPeticionDto, @PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws NotFollowingException {
        Optional<Bloc> bloc = blocService.findById(id);
        if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();
        }else{
            PeticionBloc peticionBloc = peticionBlocService.save(createPeticionDto,user,bloc.get());
            return ResponseEntity.status(HttpStatus.CREATED).body(peticionDtoConverter.PeticionBlocToGetPeticionDto(peticionBloc));
        }
    }
    @PostMapping("/accept/{id}")
    public ResponseEntity<?> acceptFollow(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){
        peticionBlocService.acceptPeticionFollow(id,user);
        return ResponseEntity.ok().build();
    }
    @PostMapping("/decline/{id}")
    public ResponseEntity<?> declineFollow(@PathVariable Long id){
        peticionBlocService.declinePeticionFollow(id);
        return ResponseEntity.ok().build();
    }
}
