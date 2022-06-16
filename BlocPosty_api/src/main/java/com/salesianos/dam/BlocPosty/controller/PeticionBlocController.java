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
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/peticion")
@Tag( name = "Peticion", description = "Clase Controller de PeticionBloc")
public class PeticionBlocController {

    private final PeticionDtoConverter peticionDtoConverter;
    private final PeticionBlocService peticionBlocService;
    private final UserEntityService userEntityService;
    private final BlocService blocService;

    @Operation(summary = "Se crea una Peticion de seguimiento a un bloc.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se crea la peticion",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = PeticionBloc.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el bloc a seguir.",
                    content = @Content),
    })

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
    @Operation(summary = "Se acepta la Peticion de seguimiento al bloc.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se acepta la peticion",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = PeticionBloc.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el bloc a aceptar.",
                    content = @Content),
    })
    @PostMapping("/accept/{id}")
    public ResponseEntity<?> acceptFollow(@PathVariable Long id, @AuthenticationPrincipal UserEntity user){
        Optional<PeticionBloc> peticion = peticionBlocService.findById(id);
        if (!peticion.isEmpty()) {
            peticionBlocService.acceptPeticionFollow(id, user);
            return ResponseEntity.ok().build();
        }
        else{
            return ResponseEntity.notFound().build();
        }
    }
    @Operation(summary = "Se rechaza la Peticion de seguimiento al bloc.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se rechaza la peticion",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = PeticionBloc.class))}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el bloc a rechazar.",
                    content = @Content),
    })
    @PostMapping("/decline/{id}")
    public ResponseEntity<?> declineFollow(@PathVariable Long id) {
        Optional<PeticionBloc> peticion = peticionBlocService.findById(id);
        if (!peticion.isEmpty()) {
            peticionBlocService.declinePeticionFollow(id);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
