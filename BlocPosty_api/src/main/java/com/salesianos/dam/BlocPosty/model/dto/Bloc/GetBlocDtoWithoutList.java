package com.salesianos.dam.BlocPosty.model.dto.Bloc;

import lombok.*;

import javax.persistence.Lob;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
public class GetBlocDtoWithoutList {

    private Long id;

    private String titulo;

    private String contenido;

    private String multimedia;

    private String userImg;

    private String userName;

}
