package com.salesianos.dam.BlocPosty.model.dto.Bloc;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.users.dto.GetUserDtoWithoutList;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Component
@RequiredArgsConstructor
public class BlocDtoConverter {

    private final BlocRepository blocRepository;

    public GetBlocDto BlocToGetBlocDto(Bloc bloc){
        return GetBlocDto.builder()
                .id(bloc.getId())
                .titulo(bloc.getTitulo())
                .contenido(bloc.getContenido())
                .multimedia(bloc.getMultimedia())
                .userImg(bloc.getUserImg())
                .userName(bloc.getUserName())
                .listaDeUsuarios(ListUserEntityToListGetUserDtoWithoutList(blocRepository.findAllUsers(bloc.getId())))
                .build();
    }
    public Bloc CreateBlocToBloc(CreateBlocDto createBlocDto,UserEntity user) {

        return Bloc.builder()
                .titulo(createBlocDto.getTitulo())
                .contenido(createBlocDto.getContenido())
                .multimedia("")
                .userImg(user.getFotoPerfil())
                .userName(user.getUsername())
                .usersInTheList(new ArrayList<>())
                .build();
    }
    private List<GetUserDtoWithoutList> ListUserEntityToListGetUserDtoWithoutList(List<UserEntity> userEntities){
        if (userEntities.isEmpty()){
            return Collections.EMPTY_LIST;
        }else{
            return userEntities.stream().map(this::UserEntityToGetUserDtoWithoutList).collect(Collectors.toList());
        }
    }
    private GetUserDtoWithoutList UserEntityToGetUserDtoWithoutList(UserEntity user){
        return GetUserDtoWithoutList.builder()
                .id(user.getId())
                .username(user.getUsername())
                .email(user.getEmail())
                .telefono(user.getTelefono())
                .avatar(user.getFotoPerfil())
                .perfil(user.getPerfil().name())
                .rol(user.getRol().name())
                .build();
    }
}
