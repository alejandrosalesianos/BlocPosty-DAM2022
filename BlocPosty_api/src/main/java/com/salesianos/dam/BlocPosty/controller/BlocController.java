package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.CreateBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.impl.BlocService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/bloc")
public class BlocController {

    private final BlocService blocService;
    private final BlocRepository blocRepository;
    private final BlocDtoConverter blocDtoConverter;
    private final UserEntityService userEntityService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findOneBloc(@PathVariable Long id) {
            Bloc bloc = blocService.findBlocById(id);
            return ResponseEntity.ok().body(blocDtoConverter.BlocToGetBlocDto(bloc));
    }

    @GetMapping("/")
    public ResponseEntity<List<GetBlocDto>> findAll() throws ListNotFoundException {
        List<Bloc> blocs = blocRepository.findAll();
            return ResponseEntity.ok().body(blocService.BlocListToGetBlocDtoList(blocs));
    }
    @PostMapping("/")
    public ResponseEntity<GetBlocDto> postBloc(@RequestBody CreateBlocDto createBlocDto, @AuthenticationPrincipal UserEntity user) throws ListNotFoundException {
        Bloc bloc = blocDtoConverter.CreateBlocToBloc(createBlocDto,user);
        blocService.save(bloc);
        UserEntity userr = userEntityService.findByUsername(user.getUsername());
        userr.addBloc(bloc);
        userEntityService.save(userr);
        GetBlocDto getBlocDto = blocDtoConverter.BlocToGetBlocDto(bloc);
        return ResponseEntity.status(HttpStatus.CREATED).body(getBlocDto);
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBloc(@PathVariable Long id){
        Optional<Bloc> bloc = blocService.findById(id);
        if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        else{
            blocService.delete(bloc.get());
            return ResponseEntity.noContent().build();
        }

    }
}
