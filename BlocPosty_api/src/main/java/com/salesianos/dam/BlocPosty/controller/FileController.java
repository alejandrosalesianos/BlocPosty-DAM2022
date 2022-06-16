package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.model.Bloc;
import com.salesianos.dam.BlocPosty.services.StorageService;
import com.salesianos.dam.BlocPosty.utils.MediaTypeUrlResource;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileNotFoundException;

@RestController
@RequiredArgsConstructor
@Tag( name = "File", description = "Clase Controller de FileController")
public class FileController {

    private final StorageService storageService;

    @Operation(summary = "Se muestra la imagen subida.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200",
                    description = "Se muestra la imagen",
                    content = {@Content(mediaType = "application/json")}),
            @ApiResponse(responseCode = "404",
                    description = "No se encuentra el bloc a editar.",
                    content = @Content),
    })
    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) throws FileNotFoundException {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.ok().header("content-type", resource.getType())
                .body(resource);
    }
}
