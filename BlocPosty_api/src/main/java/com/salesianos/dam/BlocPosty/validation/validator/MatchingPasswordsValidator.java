package com.salesianos.dam.BlocPosty.validation.validator;

import com.salesianos.dam.BlocPosty.validation.multiple.MatchingPasswords;
import org.springframework.beans.PropertyAccessorFactory;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.List;

public class MatchingPasswordsValidator implements ConstraintValidator<MatchingPasswords, Object> {

    private String password;
    private String passwordMatch;

    @Override
    public void initialize(MatchingPasswords constraintAnnotation) {
        this.password = constraintAnnotation.password();
        this.passwordMatch = constraintAnnotation.passwordMatch();
    }

    @Override
    public boolean isValid(Object o, ConstraintValidatorContext constraintValidatorContext) {

        Object passwordValue = PropertyAccessorFactory.forBeanPropertyAccess(o).getPropertyValue(password);
        Object passwordMatchValue = PropertyAccessorFactory.forBeanPropertyAccess(o).getPropertyValue(passwordMatch);

        if (passwordValue != null) {
            return passwordValue.equals(passwordMatchValue);
        } else {
            return passwordMatchValue == null;
        }
    }
}
