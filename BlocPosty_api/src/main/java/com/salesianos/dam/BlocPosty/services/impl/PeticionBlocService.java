package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.error.exception.NotFollowingException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.CreatePeticionDto;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.GetPeticionDto;
import com.salesianos.dam.BlocPosty.model.dto.peticionBloc.PeticionDtoConverter;
import com.salesianos.dam.BlocPosty.repository.PeticionBlocRepository;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.repository.UserEntityRepository;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PeticionBlocService extends BaseService<PeticionBloc,Long, PeticionBlocRepository> {

    private final PeticionDtoConverter peticionDtoConverter;
    private final UserEntityRepository userEntityRepository;
    private final UserEntityService userEntityService;

    public PeticionBloc save(CreatePeticionDto dto, UserEntity userEmisor, Bloc bloc) throws NotFollowingException {
        if (userEmisor.getUsername().equals(bloc.getUserName())){
            throw new NotFollowingException("No puedes seguirte a ti mismo");
        }else {
            return repository.save(PeticionBloc.builder()
                            .mensaje(userEmisor.getUsername()+"Ha solicitado permisos para editar el Bloc: "+bloc.getTitulo()+ " \n" +dto.getMensaje())
                            .emisor(userEmisor)
                            .receptor(bloc)
                    .build());
        }
    }
    public List<GetPeticionDto> findUserById(UUID id){
        List<PeticionBloc> listaPeticiones = repository.findByEmisorId(id);
        return listaPeticiones.stream().map(peticionDtoConverter::PeticionBlocToGetPeticionDto).collect(Collectors.toList());
    }

    public void acceptPeticionFollow(Long id, UserEntity user){
        Optional<PeticionBloc> peticionBloc = findById(id);
        Optional<UserEntity> userEntity = userEntityRepository.findFirstByUsername(user.getUsername());
        List<Bloc> blocs = userEntityRepository.findAllBlocs(user.getId());
        blocs.get(0).getUsersInTheList().add(peticionBloc.get().getEmisor());
        userEntityService.save(user);
        deleteById(id);
    }
}
