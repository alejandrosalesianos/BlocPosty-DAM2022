package com.salesianos.dam.BlocPosty.users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;

import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    Optional<UserEntity> findFirstByUsername(String username);

    boolean existsByUsername(String username);
}
