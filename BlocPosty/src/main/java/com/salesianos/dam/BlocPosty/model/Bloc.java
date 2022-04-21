package com.salesianos.dam.BlocPosty.model;

import lombok.*;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.Entity;
import javax.persistence.EntityListeners;
import javax.persistence.Id;

@Entity
@EntityListeners(AuditingEntityListener.class)
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class Bloc {

    @Id
    private Long id;

    private String titulo;

    private String contenido;

    private String multimedia;

    private String userImg;
}
