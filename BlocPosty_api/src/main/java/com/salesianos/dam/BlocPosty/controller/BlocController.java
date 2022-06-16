package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.error.exception.DeleteException;
import com.salesianos.dam.BlocPosty.error.exception.EditException;
import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.CreateBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.impl.BlocService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.model.UserType;
import com.salesianos.dam.BlocPosty.users.repository.UserEntityRepository;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import com.salesianos.dam.BlocPosty.utils.PaginationLinksUtil;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/bloc")
@Tag( name = "Bloc", description = "Clase Controller de Bloc")
public class BlocController {

    private final BlocService blocService;
    private final BlocRepository blocRepository;
    private final BlocDtoConverter blocDtoConverter;
    private final UserEntityService userEntityService;
    private final PaginationLinksUtil paginationLinksUtil;
    private final UserEntityRepository userEntityRepository;

    @Operation(summary = "Mostrar un Bloc por id.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se muestra el bloc con la id especificada",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Bloc.class))}),
            @ApiResponse(responseCode = "401",
                    description = "No se ha encontrado el bloc especificado.",
                    content = @Content),
    })
    @Transactional
    @GetMapping("/{id}")
    public ResponseEntity<?> findOneBloc(@PathVariable Long id) {
            Bloc bloc = blocService.findBlocById(id);
            return ResponseEntity.ok().body(blocDtoConverter.BlocToGetBlocDto(bloc));
    }

    @Operation(summary = "Listar todos los Blocs existentes.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan todas los Blocs",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Bloc.class))}),
            @ApiResponse(responseCode = "401",
                    description = "No se ha encontrado ningun Bloc.",
                    content = @Content),
    })
    @GetMapping("/")
    public ResponseEntity<Page<GetBlocDto>> findAll(@PageableDefault(size = 100)Pageable pageable, HttpServletRequest request) throws ListNotFoundException {
        Page<Bloc> blocs = blocRepository.findAll(pageable);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
            return ResponseEntity.ok().header("link",paginationLinksUtil.createLinkHeader(blocs,uriComponentsBuilder)).body(blocService.BlocListToGetBlocDtoList(blocs));
    }

    @Operation(summary = "Se crea un Bloc.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se listan todas las inmobiliarias",
                    content = {@Content(mediaType = "multipart/form-data",
                            schema = @Schema(implementation = Bloc.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Fallo al crear un bloc por que no se cumple alguna condicion de register.",
                    content = @Content),
    })
    @PostMapping("/")
    public ResponseEntity<GetBlocDto> postBloc(@RequestPart("bloc") CreateBlocDto createBlocDto, @AuthenticationPrincipal UserEntity user) throws ListNotFoundException {
        Bloc bloc = blocDtoConverter.CreateBlocToBloc(createBlocDto,user);
        blocService.save(bloc);
        UserEntity userr = userEntityService.findByUsername(user.getUsername());
        userr.addBloc(bloc);
        userEntityService.save(userr);
        GetBlocDto getBlocDto = blocDtoConverter.BlocToGetBlocDto(bloc);
        return ResponseEntity.status(HttpStatus.CREATED).body(getBlocDto);
    }

    @Operation(summary = "Se borra un Bloc.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "204",
                    description = "Se borra el bloc",
                    content = {@Content(mediaType = "application/json",
                            schema = @Schema(implementation = Bloc.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Fallo al Borrar un bloc por que no se cumple alguna condicion de borrar.",
                    content = @Content),
            @ApiResponse(responseCode = "404",
            description = "No se encuentra el bloc a borrar.",
            content = @Content),
    })
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBloc(@PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws DeleteException {
        Optional<Bloc> bloc = blocService.findById(id);
        if (!bloc.isEmpty() && bloc.get().getUserName().equals(user.getUsername()) || user.getRol().equals(UserType.ADMIN)){
            blocService.delete(bloc.get());
            return ResponseEntity.noContent().build();
        }
        else if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        else{
            throw new DeleteException();
        }

    }


    @Operation(summary = "Se edita un Bloc de diferentes maneras.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se borra el bloc",
                    content = {@Content(mediaType = "multipart/form-data",
                            schema = @Schema(implementation = Bloc.class))}),
            @ApiResponse(responseCode = "400",
                    description = "Fallo al editar un bloc por que no se cumple alguna condicion de edicion.",
                    content = @Content),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el bloc a editar.",
                    content = @Content),
    })
    @PutMapping("/{id}")
    public ResponseEntity<GetBlocDto> editBloc(@RequestPart("bloc") CreateBlocDto createBlocDto , @RequestPart(value = "file",required = false)MultipartFile multipartFile, @PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws EditException, IOException {
        Optional<Bloc> bloc = blocService.findById(id);
        if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();

        }
        if (!user.getUsername().equals(userEntityService.findByUsername(bloc.get().getUserName()).getUsername()) && !userEntityRepository.findAllBlocs(user.getId()).contains(bloc.get())){
            throw new EditException();
        }
        if (multipartFile == null){
            Bloc newBloc = blocService.editBlocWithoutMultimedia(id,createBlocDto,user);
            GetBlocDto getBlocDto = blocDtoConverter.BlocToGetBlocDto(newBloc);
            return ResponseEntity.ok().body(getBlocDto);
        }
        else {
            Bloc newBloc = blocService.editBloc(id,createBlocDto,multipartFile,user);
            GetBlocDto getBlocDto = blocDtoConverter.BlocToGetBlocDto(newBloc);
            return ResponseEntity.ok().body(getBlocDto);
        }
    }
}
