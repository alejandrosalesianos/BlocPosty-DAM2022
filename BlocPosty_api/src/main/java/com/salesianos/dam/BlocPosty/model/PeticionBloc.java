package com.salesianos.dam.BlocPosty.model;

import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import lombok.*;

import javax.persistence.*;

@Entity
@Builder
@NoArgsConstructor @AllArgsConstructor
@Getter @Setter

public class PeticionBloc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "emisor_id")
    private UserEntity emisor;

    @ManyToOne
    @JoinColumn(name = "receptor_id")
    private Bloc receptor;

    private String mensaje;
}
