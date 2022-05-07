package com.salesianos.dam.BlocPosty.repository;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface BlocRepository extends JpaRepository<Bloc,Long> {

    Optional<Bloc> findFirstById(Long id);

    @Query(
            """
            select b.usersInTheList
            from Bloc b
            where b.id = :id
            """
    )
    List<UserEntity> findAllUsers(@Param("id") Long id);

   Page<Bloc> findAll(Pageable pageable);
}
