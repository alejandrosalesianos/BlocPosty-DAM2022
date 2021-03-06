package com.salesianos.dam.BlocPosty.model;

import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import lombok.*;
import org.hibernate.annotations.Type;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.util.List;

@Entity
@EntityListeners(AuditingEntityListener.class)
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@Builder
public class Bloc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String titulo;

    @Lob
    @Column(columnDefinition = "VARCHAR(1500)")
    @Type(type = "org.hibernate.type.TextType")
    private String contenido;

    private String multimedia;

    private String userImg;

    private String userName;

    @ManyToMany(fetch = FetchType.LAZY)
    private List<UserEntity> usersInTheList;


}
