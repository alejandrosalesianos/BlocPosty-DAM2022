package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BlocService extends BaseService<Bloc,Long, BlocRepository> {

    private final BlocDtoConverter blocDtoConverter;

    public Bloc findBlocById(Long id){
        return this.repository.findFirstById(id).orElseThrow(() -> new UsernameNotFoundException(id + " No encontrado"));
    }

    public List<GetBlocDto> BlocListToGetBlocDtoList(List<Bloc> blocs) throws ListNotFoundException {
        if (blocs.isEmpty()){
            throw new ListNotFoundException("Bloc");
        }else {
            return blocs.stream().map(blocDtoConverter::BlocToGetBlocDto).collect(Collectors.toList());
        }

    }


}
