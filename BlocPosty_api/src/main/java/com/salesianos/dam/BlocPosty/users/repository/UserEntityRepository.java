package com.salesianos.dam.BlocPosty.users.repository;

import com.salesianos.dam.BlocPosty.model.Bloc;
import org.springframework.data.jpa.repository.JpaRepository;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    Optional<UserEntity> findFirstByUsername(String username);

    boolean existsByUsername(String username);

    @Query(
            """
            select u.blocList
            from UserEntity u
            where u.id = :id
            """
    )
    List<Bloc> findAllBlocs(@Param("id") UUID id);
}
