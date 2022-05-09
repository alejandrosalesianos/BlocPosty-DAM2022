package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.error.exception.EditException;
import com.salesianos.dam.BlocPosty.error.exception.ListNotFoundException;
import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.BlocDtoConverter;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.CreateBlocDto;
import com.salesianos.dam.BlocPosty.model.dto.Bloc.GetBlocDto;
import com.salesianos.dam.BlocPosty.repository.BlocRepository;
import com.salesianos.dam.BlocPosty.services.impl.BlocService;
import com.salesianos.dam.BlocPosty.users.model.UserEntity;
import com.salesianos.dam.BlocPosty.users.service.UserEntityService;
import com.salesianos.dam.BlocPosty.utils.PaginationLinksUtil;
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
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping("/bloc")
public class BlocController {

    private final BlocService blocService;
    private final BlocRepository blocRepository;
    private final BlocDtoConverter blocDtoConverter;
    private final UserEntityService userEntityService;
    private final PaginationLinksUtil paginationLinksUtil;

    @GetMapping("/{id}")
    public ResponseEntity<?> findOneBloc(@PathVariable Long id) {
            Bloc bloc = blocService.findBlocById(id);
            return ResponseEntity.ok().body(blocDtoConverter.BlocToGetBlocDto(bloc));
    }

    @GetMapping("/")
    public ResponseEntity<Page<GetBlocDto>> findAll(@PageableDefault(size = 100)Pageable pageable, HttpServletRequest request) throws ListNotFoundException {
        Page<Bloc> blocs = blocRepository.findAll(pageable);
        UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder.fromHttpUrl(request.getRequestURL().toString());
            return ResponseEntity.ok().header("link",paginationLinksUtil.createLinkHeader(blocs,uriComponentsBuilder)).body(blocService.BlocListToGetBlocDtoList(blocs));
    }
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
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBloc(@PathVariable Long id){
        Optional<Bloc> bloc = blocService.findById(id);
        if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();
        }
        else{
            blocService.delete(bloc.get());
            return ResponseEntity.noContent().build();
        }

    }
    @PutMapping("/{id}")
    public ResponseEntity<GetBlocDto> editBloc(@RequestPart("bloc") CreateBlocDto createBlocDto , @RequestPart("file")MultipartFile multipartFile, @PathVariable Long id, @AuthenticationPrincipal UserEntity user) throws EditException, IOException {
        Optional<Bloc> bloc = blocService.findById(id);
        if (bloc.isEmpty()){
            return ResponseEntity.notFound().build();

        }
        if (!user.getUsername().equals(userEntityService.findByUsername(bloc.get().getUserName()).getUsername())){
            throw new EditException();
        }
        else {
            Bloc newBloc = blocService.editBloc(id,createBlocDto,multipartFile,user);
            GetBlocDto getBlocDto = blocDtoConverter.BlocToGetBlocDto(newBloc);
            return ResponseEntity.ok().body(getBlocDto);
        }
    }
}
