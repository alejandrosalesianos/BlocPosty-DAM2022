package com.salesianos.dam.BlocPosty.validation.multiple;

import com.salesianos.dam.BlocPosty.validation.validator.MatchingPasswordsValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target(ElementType.TYPE)
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = MatchingPasswordsValidator.class)
public @interface MatchingPasswords {

    String message() default "Las contraseñas no coinciden";

    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};

    String password();

    String passwordMatch();

    @Target({ElementType.TYPE})
    @Retention(RetentionPolicy.RUNTIME)
    @interface List {
        MatchingPasswords[] value();
    }
}
