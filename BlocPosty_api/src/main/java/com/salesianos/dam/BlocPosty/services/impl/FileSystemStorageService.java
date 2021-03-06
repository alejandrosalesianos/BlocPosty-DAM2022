package com.salesianos.dam.BlocPosty.services.impl;

import com.salesianos.dam.BlocPosty.config.StorageProperties;
import com.salesianos.dam.BlocPosty.error.exception.StorageException;
import com.salesianos.dam.BlocPosty.services.StorageService;
import com.salesianos.dam.BlocPosty.utils.MediaTypeUrlResource;
import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.util.FileSystemUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.stream.Stream;

@Service
public class FileSystemStorageService implements StorageService {

    private final Path rootLocation;

    @Autowired
    public FileSystemStorageService(StorageProperties properties) {
        this.rootLocation = Paths.get(properties.getLocation());
    }

    @PostConstruct
    @Override
    public void init() {
        try {
            Files.createDirectories(rootLocation);
        } catch (IOException ex){
            throw new StorageException("No se pudo inicializar la localización de almacenamiento",ex);
        }

    }

    @Override
    public String store(MultipartFile file) {
        String filename = StringUtils.cleanPath(file.getOriginalFilename());
        String newFilename = "";
        try {
            if (file.isEmpty())
                throw new StorageException("El fichero subido está vacío");

            newFilename = filename;
            while (Files.exists(rootLocation.resolve(newFilename))) {
                String extension = StringUtils.getFilenameExtension(newFilename);
                String name = newFilename.replace("." + extension, "");

                String suffix = Long.toString(System.currentTimeMillis());
                suffix = suffix.substring(suffix.length() - 6);

                newFilename = name + "_" + suffix + "." + extension;
            }

            try (InputStream inputStream = file.getInputStream()) {
                Files.copy(inputStream, rootLocation.resolve(newFilename), StandardCopyOption.REPLACE_EXISTING);
            }

        } catch (IOException ex) {
                throw new StorageException("Error en el almacenamiento del fichero: " + newFilename, ex);
        }

        return newFilename;

    }

    @Override
    public Stream<Path> loadAll() {
        try{
            return Files.walk(this.rootLocation,1).filter(path -> !path.equals(this.rootLocation))
                    .map(this.rootLocation::relativize);
        } catch (IOException ex){
            throw new StorageException("Error al leer los ficheros almacenados",ex);
        }
    }

    @Override
    public Path load(String filename) {
        return rootLocation.resolve(filename);
    }

    @Override
    public Resource loadAsResource(String filename) {
        try {
            Path file = load(filename);
            MediaTypeUrlResource resource = new MediaTypeUrlResource(file.toUri());
            if (resource.exists() || resource.isReadable()) {
                return resource;
            }
            else {
                throw new FileNotFoundException("No se pudo leer el archivo: " +filename);
            }
        } catch (MalformedURLException | FileNotFoundException ex) {
            try {
                throw new FileNotFoundException("No se pudo leer el archivo: " +filename);
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @Override
    public void deleteFile(String filename) {
        String justFilename = StringUtils.getFilename(filename);
        try {
            Path file = load(justFilename);
            Files.deleteIfExists(file);
        } catch (IOException ex) {
            throw new StorageException("Error al eliminar un fichero", ex);
        }
    }

    @Override
    public void deleteAll() {
        FileSystemUtils.deleteRecursively(rootLocation.toFile());
    }

    @Override
    public BufferedImage simpleResizer(BufferedImage bufferedImage, int width) {
        return Scalr.resize(bufferedImage,width);
    }
}
