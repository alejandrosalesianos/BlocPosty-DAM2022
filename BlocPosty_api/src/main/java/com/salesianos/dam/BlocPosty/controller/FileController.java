package com.salesianos.dam.BlocPosty.controller;

import com.salesianos.dam.BlocPosty.services.StorageService;
import com.salesianos.dam.BlocPosty.utils.MediaTypeUrlResource;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.io.FileNotFoundException;

@RestController
@RequiredArgsConstructor
public class FileController {

    private final StorageService storageService;

    @GetMapping("/download/{filename:.+}")
    public ResponseEntity<Resource> getFile(@PathVariable String filename) throws FileNotFoundException {
        MediaTypeUrlResource resource = (MediaTypeUrlResource) storageService.loadAsResource(filename);

        return ResponseEntity.ok().header("content-type", resource.getType())
                .body(resource);
    }
}
