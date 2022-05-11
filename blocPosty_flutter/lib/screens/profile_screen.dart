import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_posty/Bloc/bloc_user/user_bloc.dart';
import 'package:flutter_bloc_posty/model/user/me_response.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository.dart';
import 'package:flutter_bloc_posty/repository/user/user_repository_impl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
  with TickerProviderStateMixin {
  late TabController tabController;
  late UserRepository userRepository;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    userRepository = UserRepositoryImpl();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BlocProvider(
            create: (context) {
              return UserBloc(userRepository)..add(FetchUsersEvent());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: _createUserDetail(context),
            ),
          ),
        ],
      ),
    );
  }

  _createBlocsUser(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildBlocsUser(context, state.meResponse);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildBlocsUser(BuildContext context, MeResponse user) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GridView.count(

          crossAxisCount: 2,
          children: List.generate(user.blocs.length, (index) {
            return Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 50,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Text(
                      '${user.blocs.elementAt(index).titulo}',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${user.blocs.elementAt(index).contenido}',textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 8,
                      ),
                    ),
                  ],
                ),
                
              ),
            );
          }),
        ),
      ),
    );
  }

  _createUserDetail(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is UserFetched) {
        return _buildUserDetail(context, state.meResponse);
      } else {
        return const Text('No soportado');
      }
    });
  }

  _buildUserDetail(BuildContext context, MeResponse meResponse) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(Icons.lock),
                    SizedBox(width: 4.0),
                    Text(
                      meResponse.username,
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 254, 254)),
                    ),
                    SizedBox(width: 12.0),
                    Container(
                      alignment: Alignment.center,
                      width: 35.0,
                      height: 25.0,
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.add_box_outlined),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.menu),
                      )
                    ],
                  ))
            ],
          )),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        meResponse.avatar))),
                          ),
                          Column(
                            children: [
                              Text(
                                meResponse.blocs.length.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "    Blocs\n Públicos",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "0",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "        Blocs\n compartidos",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                meResponse.peticiones.length.toString(),
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                "Peticiones",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Alejandro Martin Cueva",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              Text("Sevilla",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ])),
                    SizedBox(height: 12.0),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 350.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  width: 2.0,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              child: Text("Editar Perfil",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                            ),
                            Icon(Icons.expand_more_outlined,
                                color: Color.fromARGB(255, 0, 0, 0))
                          ]),
                    ),
                    SizedBox(height: 24.0),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 350.0,
                              height: 35.0,
                              child: Text("Blocs populares",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold)),
                            ),
                            Icon(Icons.expand_more_outlined,
                                color: Color.fromARGB(255, 0, 0, 0))
                          ]),
                    ),
                    Divider(
                      color: Colors.grey[800],
                      thickness: 2.0,
                    ),         
                    SizedBox(
            height: 70,
            child: TabBar(
              indicatorColor: Colors.grey,
              controller: tabController,
              tabs: const [
                Tab(
                    icon: Icon(
                  Icons.table_chart_outlined,
                  color: Colors.grey,
                )),
                Tab(
                    icon: Icon(
                  Icons.person_pin_outlined,
                  color: Colors.grey,
                )),
              ],
            ),
          ),
          SizedBox(
            height: 230.0,
            child: TabBarView(
              controller: tabController,
              children: [
                BlocProvider(
                  create: (context) {
                    return UserBloc(userRepository)..add(FetchUsersEvent());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: _createBlocsUser(context),
                  ),
                ),
                Text('Tab 2')
              ],
            ),
          ),
          ],
          ),
        ),
            ]),
    )));
  }
}