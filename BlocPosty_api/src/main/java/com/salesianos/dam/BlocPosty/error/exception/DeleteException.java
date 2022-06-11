package com.salesianos.dam.BlocPosty.error.exception;

public class DeleteException extends Throwable{

    public DeleteException (){
        super("No puedes borrar un bloc que no es tuyo");
    }
}
