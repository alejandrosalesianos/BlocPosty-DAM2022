# BlocPosty-DAM2022

## URL de la aplicación desplegada

`https://bloc-posty.herokuapp.com`

## URL de la Web desplegada

`https://bloc-posty-web.herokuapp.com/`



Este proyecto ha sido desarrollado Alejandro Martín Cuevas

Programas empleados:

- API: IntelliJ idea
- Postman
- Angular: VisualStudio code

>## Funcionalidad
  Bloc Posty es una aplicación de tipo red social donde su principal atractivo es el uso de blocs de notas para comunicarse con otra gente, escribiendo en estos mismos tus rutinas o lo que quieras compartir con el mundo.
  
  Creando peticiones (usando API REST) desde las entidades, asociaciones y aplicando cambios en la forma de mostrar su estructura a través de Dtos para luego mostrar y modificar esos datos realizando a través de angular.
  
>## Instrucciones de arranque
  Para ejecutar esta aplicación tras clonar el repositorio, debes ejecutar en la consola de tu IDE, "spring-boot:run", con la configuración de Maven. O bien puedes usar la url provista mas arriba para empezar a usar el postman

>## Paquetes principales
| Paquete | URL |
| ------ | ------ |
| API | [BlocPosty-Api](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api) |
| WEB | [BlocPosty-web](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_web) |
| MOBILE | [BlocPosty-mobile](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/blocPosty_flutter) |

>## Estructura de paquetes
| Paquete | URL |
| ------ | ------ |
| Controllers | [BlocPosty/Controllers](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/controller) |
| DTOs | [BlocPosty/DTOs](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/model/dto) |
| Models | [BlocPosty/Models](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/model) |
| Repositories | [BlocPosty/Repositories](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/repositories)
| Services | [BlocPosty/Services](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/services)
| Util | [BlocPosty/Utils](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/utils)
| Config | [BlocPosty/Config](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/config)
| Users | [BlocPosty/Users](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/users)
| Validation | [BlocPosty/Validation](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty_api/src/main/java/com/salesianos/dam/BlocPosty/validation)
| Lib (Flutter) | [BlocPosty/LibFlutter](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/blocPosty_flutter/lib)
| Src (Angular) | [BlocPosty/SrcAngular](https://github.com/alejandrosalesianos/BlocPosty-DAM2022/tree/master/BlocPosty-web/src)

>## Entidades
  Contamos con 3 entidades que son:
  - UserEntity
  - Bloc
  - PeticionBloc

  
>## Asociaciones
## ManytoMany ( UserEntity -> Usuario_bloc <- Bloc )


## ManyToOne bidireccional (Bloc -> PeticionBloc)
