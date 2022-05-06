package com.salesianos.dam.BlocPosty.repository;

import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface PeticionBlocRepository extends JpaRepository<PeticionBloc,Long> {

    List<PeticionBloc> findByEmisorId(UUID id);
}
