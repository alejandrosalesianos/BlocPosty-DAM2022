import 'package:flutter/material.dart';
import 'package:flutter_bloc_posty/data/constant.dart';
import 'package:flutter_bloc_posty/json/notes_json.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      backgroundColor: bgColor,
      body: getBody(),
      bottomSheet: getFooter(),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: bgColor,
        child: Center(
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/OOjs_UI_icon_add.svg/1024px-OOjs_UI_icon_add.svg.png",
            width: 30,
          ),
        ),
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15,top: 65),
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
          SizedBox(
            height: 15,
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
              SizedBox(
                height: 10,
              ),
              getGridView()
            ],
          )
        ],
      ),
    );
  }

  Widget getGridView() {
    var size = MediaQuery.of(context).size;
    return Column(
      children: List.generate(notes.length, (index) {
        List img = notes[index]['img'];
        return GestureDetector(
          onTap: () {},
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: cardColor,
                    border: Border.all(color: white.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 12, left: 8, right: 8, bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notes[index]['title'],
                        style: TextStyle(
                            fontSize: 15,
                            color: white.withOpacity(0.9),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(notes[index]['description'],
                          style: TextStyle(
                              fontSize: 13,
                              height: 1.5,
                              color: white.withOpacity(0.7),
                              fontWeight: FontWeight.w400)),
                      img.length > 0
                          ? Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                Row(
                                    children:
                                        List.generate(img.length, (index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: white.withOpacity(0.1)),
                                          image: DecorationImage(
                                              image: NetworkImage(img[index]),
                                              fit: BoxFit.cover)),
                                    ),
                                  );
                                }))
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          )
          );
      }),
    );
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 80,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: black.withOpacity(0.2), spreadRadius: 1, blurRadius: 3)
      ], color: bgColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: [
              Container(
                width: size.width * 0.7,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.ac_unit,
                        size: 20,
                        color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.ac_unit,
                        size: 18,
                        color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.mic_rounded,
                        size: 22,
                        color: white.withOpacity(0.5),
                      ),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.ac_unit,
                        size: 22,
                        color: white.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}