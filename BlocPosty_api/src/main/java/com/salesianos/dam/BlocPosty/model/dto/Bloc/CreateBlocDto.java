package com.salesianos.dam.BlocPosty.model.dto.Bloc;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateBlocDto {

    private String titulo;

    private String contenido;

}
