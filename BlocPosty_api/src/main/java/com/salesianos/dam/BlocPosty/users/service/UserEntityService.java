package com.salesianos.dam.BlocPosty.users.service;

import com.salesianos.dam.BlocPosty.services.StorageService;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import com.salesianos.dam.BlocPosty.users.dto.CreateUserDto;
import com.salesianos.dam.BlocPosty.users.dto.UserDtoConverter;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.repository.UserEntityRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;

@Service("userDetailService")
@RequiredArgsConstructor
public class UserEntityService extends BaseService<UserEntity, UUID, UserEntityRepository> implements UserDetailsService {

    private final PasswordEncoder passwordEncoder;
    private final StorageService storageService;
    private final UserDtoConverter userDtoConverter;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return this.repository.findFirstByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username + " No encontrado"));
    }
    public UserEntity findByUsername(String username){
        return this.repository.findFirstByUsername(username).orElseThrow(() -> new UsernameNotFoundException(username+ " No encontrado"));
    }
    public UserEntity saveUser(CreateUserDto userDto, MultipartFile file) throws IOException {

        if (userDto.getPassword().equals(userDto.getPassword2())){
            String filename = storageService.store(file);

            String extension = StringUtils.getFilenameExtension(filename);

            BufferedImage originalImage = ImageIO.read(file.getInputStream());

            BufferedImage scaledImage = storageService.simpleResizer(originalImage,256);

            OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

            ImageIO.write(scaledImage,extension,outputStream);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            UserEntity user = UserEntity.builder()
                    .username(userDto.getUsername())
                    .email(userDto.getEmail())
                    .fotoPerfil(uri)
                    .password(passwordEncoder.encode(userDto.getPassword()))
                    .rol(userDto.getPermisos())
                    .perfil(userDto.getPerfil())
                    .telefono(userDto.getTelefono())
                    .blocList(new ArrayList<>())
                    .build();
            return repository.save(user);
        } else{
            return null;
        }
    }

    public UserEntity edit (UUID id, CreateUserDto createUserDto, MultipartFile file, UserEntity userEntity) throws Exception {
        if (createUserDto.getPassword().equals(createUserDto.getPassword2())){

            Optional<UserEntity> user = repository.findById(id);

            if (!user.isPresent()){
                throw new UsernameNotFoundException("No se encontro al usuario especificado");
            }
            else {
                storageService.deleteFile(user.get().getFotoPerfil());

                String filename = storageService.store(file);

                String extension = StringUtils.getFilenameExtension(filename);

                BufferedImage originalImage = ImageIO.read(file.getInputStream());

                BufferedImage escaledImage = storageService.simpleResizer(originalImage,128);

                OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

                ImageIO.write(escaledImage,extension,outputStream);

                String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("/download/")
                        .path(filename)
                        .toUriString();

                return user.map(newUser -> save(newUser.builder()
                        .id(userEntity.getId())
                        .username(createUserDto.getUsername())
                        .email(createUserDto.getEmail())
                        .fotoPerfil(uri)
                        .password(passwordEncoder.encode(createUserDto.getPassword()))
                        .rol(createUserDto.getPermisos())
                        .perfil(createUserDto.getPerfil())
                        .telefono(createUserDto.getTelefono())
                        .blocList(userEntity.getBlocList())
                        .build())).get();
            }
        }
        else {
            throw new Exception("Las contraseñas no coinciden");
        }
    }
}
