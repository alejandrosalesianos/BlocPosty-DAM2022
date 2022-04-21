package com.salesianos.dam.BlocPosty.repository;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface BlocRepository extends JpaRepository<Bloc,Long> {

    Optional<Bloc> findFirstById(Long id);
}
