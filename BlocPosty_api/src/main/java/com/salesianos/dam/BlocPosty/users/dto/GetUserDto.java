package com.salesianos.dam.BlocPosty.users.dto;

import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDtoWithoutList;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.GetPeticionDto;
import lombok.*;

import java.util.List;
import java.util.UUID;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter @Setter
public class GetUserDto {

    private UUID id;
    private String username;
    private String email;
    private String telefono;
    private String perfil;
    private String rol;
    private String avatar;
    private List<GetBlocDtoWithoutList> Blocs;
    private List<GetPeticionDto> peticiones;
}
