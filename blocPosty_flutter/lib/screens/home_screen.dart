import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_user/user_bloc.dart';
import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository_impl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserRepository userRepository;

  @override
  void initState() {
    userRepository = UserRepositoryImpl();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 65),
                child: Container(
                  width: size.width,
                  height: 45,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3)
                  ], color: cardColor, borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search your notes",
                              style: TextStyle(
                                  fontSize: 15, color: white.withOpacity(0.7)),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.grid_view,
                              color: white.withOpacity(0.7),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://lh3.googleusercontent.com/a-/AOh14GhqYCtgODjBQZ2EcAvJApnWnnDPgZe80-AMM6tctw=s600-k-no-rp-mo"),
                                      fit: BoxFit.cover)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      "PINNED",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: white.withOpacity(0.6)),
                    ),
                  ),
                  BlocProvider(
                    create: (context) {
                      return UserBloc(userRepository)..add(FetchUsersEvent());
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 200,
                      child: _createBlocsUser(context),
                    ),
                  ),
                  //getGridView()
                ],
              )
            ],
          ),
        ));
  }

  _createBlocsUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildAllBlocs(context, state.meResponse);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildAllBlocs(BuildContext context, MeResponse meResponse) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: StaggeredGridView.countBuilder(
          staggeredTileBuilder: (int index) =>
              index % 7 == 0 ? StaggeredTile.count(2, 3) : StaggeredTile.fit(2),
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 3,
          itemCount: meResponse.blocs.length,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.only(right: 10, bottom: 10),

                decoration: BoxDecoration(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.7),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 80,
                height: 100,
                child:
                    buildBlocContent(meResponse.blocs.elementAt(index), index));
          },
        ));
  }

  buildBlocContent(Blocs blocModel, int index) {
    if (index % 7 == 0 && blocModel.multimedia.isNotEmpty) {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 2,right: 2),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 7,
            ),
          ),
        ],
      );
    }
    if (index % 7 == 0) {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 2,right: 2),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 15,
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          getImgBloc(context, blocModel, index),
          Text(
            '${blocModel.titulo}',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10,left: 2,right: 2),
            child: Text(
              '${blocModel.contenido}',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      );
    }
  }

  getImgBloc(BuildContext context, Blocs bloc, int index) {
    if (bloc.multimedia.isEmpty) {
      return Text('');
    } else if (index % 7 == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Image.network('${bloc.multimedia}'),
        ),
      );
    } else {
      return Text('');
    }
  }
}
