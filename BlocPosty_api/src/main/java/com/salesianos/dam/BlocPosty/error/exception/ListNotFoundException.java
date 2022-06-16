package com.salesianos.dam.BlocPosty.error.exception;

public class ListNotFoundException extends Throwable {

    public ListNotFoundException (String mensaje){
        super("No se encontro la lista de " + mensaje);
    }
}
