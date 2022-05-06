package com.salesianos.dam.BlocPosty.model.dto.peticionBloc;

import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import org.springframework.stereotype.Component;

@Component
public class PeticionDtoConverter {

    public GetPeticionDto PeticionBlocToGetPeticionDto(PeticionBloc peticionBloc){
        return GetPeticionDto.builder()
                .id(peticionBloc.getId())
                .emisor(peticionBloc.getEmisor().getUsername())
                .receptor(peticionBloc.getReceptor().getTitulo())
                .mensaje(peticionBloc.getMensaje())
                .build();
    }
}
