import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_user/user_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/peticion_bloc/peticion_bloc.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository.dart';
import 'package:flutter_bloc_posty/repository/peticion/peticion_repository_impl.dart';

class PeticionesScreen extends StatefulWidget {
  const PeticionesScreen({Key? key}) : super(key: key);

  @override
  State<PeticionesScreen> createState() => _PeticionesScreenState();
}

class _PeticionesScreenState extends State<PeticionesScreen> {
  late PeticionRepository peticionRepository;

  @override
  void initState() {
    peticionRepository = PeticionRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: BlocProvider(
        create: (context) {
          return PeticionBloc(peticionRepository)..add(FetchPeticionesEvent());
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _createPeticionesUser(context),
        ),
      )),
    );
  }

  _createPeticionesUser(BuildContext context) {
    return BlocBuilder<PeticionBloc, PeticionState>(builder: (context, state) {
      if (state is PeticionInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is PeticionesFetched) {
        return _buildPeticiones(context, state.peticiones);
      } else {
        return const Text('Fallo al cargar las peticiones');
      }
    });
  }

  _buildPeticiones(BuildContext context, List<Peticiones> peticiones) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
            itemCount: peticiones.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                height: 150,
                child: _BuildOnePeticion(peticiones.elementAt(index)),
              );
            }),
      ),
    );
  }

  _BuildOnePeticion(Peticiones peticion) {
    return Card(
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          peticion.mensaje,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 3,
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(right: 2),
                child: Expanded(
                  child: Icon(Icons.arrow_forward),
                  flex: 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Expanded(
                      flex: 7,
                      child: ListTile(
                        title: Text("De: " + peticion.emisor),
                        subtitle: Text("Para: " + peticion.receptor),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          TextButton(
                            child: Text("Aceptar"),
                            onPressed: () {
                              BlocProvider.of<PeticionBloc>(context)
                                  .add(AcceptPeticionEvent(peticion.id));
                            },
                          ),
                          TextButton(
                            child: Text("Rechazar"),
                            onPressed: () {
                              BlocProvider.of<PeticionBloc>(context)
                                  .add(DeclinePeticionEvent(peticion.id));
                              Navigator.pushNamed(context, '/menu');
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              flex: 8,
            ),
          ],
        ),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(10),
    );
  }
}
