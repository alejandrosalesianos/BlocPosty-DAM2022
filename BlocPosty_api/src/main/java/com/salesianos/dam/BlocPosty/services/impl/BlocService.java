package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.CreateBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.StorageService;
import com.salesianos.dam.BlocPosty.services.base.BaseService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class BlocService extends BaseService<Bloc,Long, BlocRepository> {

    private final BlocDtoConverter blocDtoConverter;
    private final StorageService storageService;

    public Bloc findBlocById(Long id) {
        return this.repository.findFirstById(id).orElseThrow(() -> new UsernameNotFoundException(id + " No encontrado"));
    }

    public Page<GetBlocDto> BlocListToGetBlocDtoList(Page<Bloc> blocs) throws ListNotFoundException {
        if (blocs.isEmpty()) {
            throw new ListNotFoundException("Bloc");
        } else {
            return new PageImpl<>(blocs.stream().map(blocDtoConverter::BlocToGetBlocDto).collect(Collectors.toList()));
        }

    }

    public Bloc editBloc(Long id, CreateBlocDto createBlocDto, MultipartFile file, UserEntity userEntity) throws IOException {
        Optional<Bloc> bloc = repository.findById(id);

        if (bloc.isEmpty()) {
            throw new UsernameNotFoundException("No se encontro el bloc especificado");
        }
        if (!bloc.get().getMultimedia().isEmpty() && file.isEmpty()) {
            storageService.deleteFile(bloc.get().getMultimedia());

            return bloc.map(newBloc -> save(newBloc.builder()
                    .id(id)
                    .titulo(createBlocDto.getTitulo())
                    .contenido(createBlocDto.getContenido())
                    .multimedia("")
                    .userImg(bloc.get().getUserImg())
                    .userName(bloc.get().getUserName())
                    .usersInTheList(bloc.get().getUsersInTheList())
                    .build())).get();
        }
        if (!bloc.get().getMultimedia().isEmpty()) {
            storageService.deleteFile(bloc.get().getMultimedia());

            String filename = storageService.store(file);

            String extension = StringUtils.getFilenameExtension(filename);

            BufferedImage originalImage = ImageIO.read(file.getInputStream());

            BufferedImage escaledImage = storageService.simpleResizer(originalImage, 256);

            OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

            ImageIO.write(escaledImage, extension, outputStream);

            String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                    .path("/download/")
                    .path(filename)
                    .toUriString();

            return bloc.map(newBloc -> save(newBloc.builder()
                    .id(id)
                    .titulo(createBlocDto.getTitulo())
                    .contenido(createBlocDto.getContenido())
                    .multimedia(uri)
                    .userImg(bloc.get().getUserImg())
                    .userName(bloc.get().getUserName())
                    .usersInTheList(bloc.get().getUsersInTheList())
                    .build())).get();
        }
        else{
                String filename = storageService.store(file);

                String extension = StringUtils.getFilenameExtension(filename);

                BufferedImage originalImage = ImageIO.read(file.getInputStream());

                BufferedImage escaledImage = storageService.simpleResizer(originalImage, 256);

                OutputStream outputStream = Files.newOutputStream(storageService.load(filename));

                ImageIO.write(escaledImage, extension, outputStream);

                String uri = ServletUriComponentsBuilder.fromCurrentContextPath()
                        .path("/download/")
                        .path(filename)
                        .toUriString();

                return bloc.map(newBloc -> save(newBloc.builder()
                        .id(id)
                        .titulo(createBlocDto.getTitulo())
                        .contenido(createBlocDto.getContenido())
                        .multimedia(uri)
                        .userImg(bloc.get().getUserImg())
                        .userName(bloc.get().getUserName())
                        .usersInTheList(bloc.get().getUsersInTheList())
                        .build())).get();
            }
        }

    public Bloc editBlocWithoutMultimedia(Long id, CreateBlocDto createBlocDto, UserEntity userEntity) throws IOException {
        Optional<Bloc> bloc = repository.findById(id);

        return bloc.map(newBloc -> save(newBloc.builder()
                .id(id)
                .titulo(createBlocDto.getTitulo())
                .contenido(createBlocDto.getContenido())
                .multimedia("")
                .userImg(bloc.get().getUserImg())
                .userName(bloc.get().getUserName())
                .usersInTheList(bloc.get().getUsersInTheList())
                .build())).get();
    }
}
