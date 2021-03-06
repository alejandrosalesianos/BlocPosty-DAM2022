package com.salesianos.dam.BlocPosty.users.model;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.PeticionBloc;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "usuarios")
@EntityListeners(AuditingEntityListener.class)
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class UserEntity implements UserDetails {

    @Id
    @Column(name = "ID")
    @GeneratedValue
    @GenericGenerator(
            name = "UUID",
            strategy = "org.hibernate.id.UUIDGenerator",
            parameters = {
                    @org.hibernate.annotations.Parameter(name = "uuid_gen_strategy_class",
                            value = "org.hibernate.id.uuid.CustomVersionOneStrategy"
                    )
            }
    )
    private UUID id;

    private String username;

    private String email;

    private String fotoPerfil;

    private String password;

    private String telefono;

    @Enumerated(EnumType.STRING)
    private UserType rol;

    @Enumerated(EnumType.STRING)
    private UserProfile perfil;

    @ManyToMany(mappedBy = "usersInTheList")
    private List<Bloc> blocList;

    @OneToMany(mappedBy = "userReceptor")
    private List<PeticionBloc> solicitudes;



    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority("ROLE_"+ rol.name()));
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public void addBloc(Bloc b) {
        if (this.getBlocList() == null) {
            this.setBlocList(new ArrayList<>());
        }
        this.getBlocList().add(b);

        if (b.getUsersInTheList() == null)
            b.setUsersInTheList(new ArrayList<>());
        b.getUsersInTheList().add(this);
    }
}
