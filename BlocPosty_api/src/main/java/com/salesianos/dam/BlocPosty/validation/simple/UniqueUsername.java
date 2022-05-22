package com.salesianos.dam.BlocPosty.validation.simple;

import com.salesianos.dam.BlocPosty.validation.validator.UniqueUsernameValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD, ElementType.METHOD})
@Constraint(validatedBy = UniqueUsernameValidator.class)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface UniqueUsername {

    String message() default "Este usuario ya existe";
    Class <?> [] group() default {};
    Class < ? extends Payload> [] payload() default {};
}
