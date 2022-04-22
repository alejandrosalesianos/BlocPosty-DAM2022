import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> 
  with TickerProviderStateMixin{
    late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      "Skyador",
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
                                    image: AssetImage(
                                        'assets/images/muramasa.png'))),
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
                                "0",
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
                              child: Text("Historias Destacadas",
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
          ),],
          ),
        ),
            ]),
    )));
  }
}