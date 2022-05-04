package com.salesianos.dam.BlocPosty.users.dto;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.GetBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.GetBlocDtoWithoutList;
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
}
