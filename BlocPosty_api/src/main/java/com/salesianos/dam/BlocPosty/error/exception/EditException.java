package com.salesianos.dam.BlocPosty.error.exception;

public class EditException extends Throwable{

    public EditException (){
        super("No puedes editar un perfil que no es tuyo");
    }
}
