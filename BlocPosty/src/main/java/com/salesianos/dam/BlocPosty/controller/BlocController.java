package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.services.impl.BlocService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/bloc")
public class BlocController {

    private final BlocService blocService;

    @GetMapping("/{id}")
    public ResponseEntity<?> findOneBloc(@PathVariable Long id){
        if (blocService.findBlocById(id) != null)
        return ResponseEntity.ok().body(blocService.findBlocById(id));
        else {
            return ResponseEntity.notFound().build();
        }
    }
}
