package com.salesianos.dam.BlocPosty.error.exception;

import java.io.IOException;

public class StorageException extends RuntimeException {
    public StorageException(String s, IOException ex) {
        super(s);
    }
    public StorageException(String s){
        super(s);
    }
}
