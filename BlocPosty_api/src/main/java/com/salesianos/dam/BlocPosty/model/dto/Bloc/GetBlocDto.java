package com.salesianos.dam.BlocPosty.model.dto.Bloc;

import com.salesianos.dam.BlocPosty.users.dto.GetUserDtoWithoutList;
import lombok.*;

import javax.persistence.Lob;
import java.util.List;

@AllArgsConstructor @NoArgsConstructor
@Getter
@Setter
@Builder
public class GetBlocDto {

    private Long id;

    private String titulo;

    private String contenido;

    private String multimedia;

    private String userImg;

    private String userName;

    private List<GetUserDtoWithoutList> listaDeUsuarios;
}
