package com.salesianos.dam.BlocPosty.model.dto.peticionBloc;

import lombok.*;

@Builder
@Getter @Setter
@NoArgsConstructor @AllArgsConstructor

public class GetPeticionDto {

    private Long id;
    private String emisor;
    private String userReceptor;
    private String receptor;
    private String mensaje;
}
