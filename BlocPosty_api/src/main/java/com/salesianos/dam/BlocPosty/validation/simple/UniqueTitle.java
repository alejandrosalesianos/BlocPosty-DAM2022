package com.salesianos.dam.BlocPosty.validation.simple;

import javax.validation.Constraint;
import java.lang.annotation.*;

@Target({ElementType.FIELD,ElementType.METHOD})
@Documented
@Retention(RetentionPolicy.RUNTIME)
//@Constraint(validatedBy = UniqueTitleValidator.class)
public @interface UniqueTitle {


}
