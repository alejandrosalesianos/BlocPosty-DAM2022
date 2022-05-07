package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.CreateBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BlocService extends BaseService<Bloc,Long, BlocRepository> {

    private final BlocDtoConverter blocDtoConverter;

    public Bloc findBlocById(Long id){
        return this.repository.findFirstById(id).orElseThrow(() -> new UsernameNotFoundException(id + " No encontrado"));
    }

    public Page<GetBlocDto> BlocListToGetBlocDtoList(Page<Bloc> blocs) throws ListNotFoundException {
        if (blocs.isEmpty()){
            throw new ListNotFoundException("Bloc");
        }else {
            return new PageImpl<>(blocs.stream().map(blocDtoConverter::BlocToGetBlocDto).collect(Collectors.toList()));
        }

    }
    public Bloc editBloc(CreateBlocDto createBlocDto, MultipartFile file, UserEntity userEntity){
        return null;
    }


}
