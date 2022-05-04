package com.salesianos.dam.BlocPosty.users.dto;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.GetBlocDtoWithoutList;
import com.salesianos.dam.BlocPosty.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class UserDtoConverter {

    private final UserEntityRepository userEntityRepository;

    public GetUserDto UserEntityToGetUserDto(UserEntity user){

        return GetUserDto.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .telefono(user.getTelefono())
                .avatar(user.getFotoPerfil())
                .perfil(user.getPerfil().name())
                .rol(user.getRol().name())
                .Blocs(ListBlocToListGetBlocDtoWithoutList(userEntityRepository.findAllBlocs(user.getId())))
                .build();
    }
    private List<GetBlocDtoWithoutList> ListBlocToListGetBlocDtoWithoutList(List<Bloc> blocs){
        if (blocs.isEmpty()){
            return Collections.EMPTY_LIST;
        }else{
        return blocs.stream().map(this::BlocToGetBlocDtoWithoutList).collect(Collectors.toList());
        }
    }
    private GetBlocDtoWithoutList BlocToGetBlocDtoWithoutList(Bloc bloc){
        return GetBlocDtoWithoutList.builder()
                .id(bloc.getId())
                .titulo(bloc.getTitulo())
                .contenido(bloc.getContenido())
                .multimedia(bloc.getMultimedia())
                .userImg(bloc.getUserImg())
                .userName(bloc.getUserName())
                .build();
    }

}