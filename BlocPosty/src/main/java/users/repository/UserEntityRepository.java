package users.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import users.model.UserEntity;

import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    Optional<UserEntity> findFirstByUsername(String username);
}
