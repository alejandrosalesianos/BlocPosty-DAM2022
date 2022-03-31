package users.dto;

import lombok.*;
import users.model.UserProfile;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter @Setter
public class CreateUserDto {

    private String username;

    private String email;

    private String telefono;

    private UserProfile perfil;

    private String password;

    private String password2;
}
