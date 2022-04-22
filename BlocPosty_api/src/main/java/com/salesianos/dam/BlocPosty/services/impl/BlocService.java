package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class BlocService extends BaseService<Bloc,Long, BlocRepository> {



    public Bloc findBlocById(Long id){
        return this.repository.findFirstById(id).orElseThrow(() -> new UsernameNotFoundException(id + " No encontrado"));
    }
}
