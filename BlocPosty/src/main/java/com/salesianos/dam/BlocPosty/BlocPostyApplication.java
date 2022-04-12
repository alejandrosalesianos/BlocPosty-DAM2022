package com.salesianos.dam.BlocPosty;

import com.salesianos.dam.BlocPosty.config.StorageProperties;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;

@EnableConfigurationProperties(StorageProperties.class)
@SpringBootApplication
public class BlocPostyApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlocPostyApplication.class, args);
	}

}
