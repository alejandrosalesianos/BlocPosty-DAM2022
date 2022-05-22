package com.salesianos.dam.BlocPosty.validation.validator;

import com.salesianos.dam.BlocPosty.users.repository.UserEntityRepository;
import com.salesianos.dam.BlocPosty.validation.simple.UniqueUsername;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

public class UniqueUsernameValidator implements ConstraintValidator<UniqueUsername, String> {

    @Autowired
    private UserEntityRepository userEntityRepository;

    @Override
    public void initialize(UniqueUsername constraintAnnotation) {
    }

    @Override
    public boolean isValid(String s, ConstraintValidatorContext constraintValidatorContext) {
        return StringUtils.hasText(s) && !userEntityRepository.existsByUsername(s);
    }
}
