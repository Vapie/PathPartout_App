
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/ui/level.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/media/slide-loadimages.dart';

class RandoTile extends StatelessWidget {
  var rando;


  RandoTile(Rando rando, {Key key}) : super(key: key){
    this.rando = rando;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Expanded(
          child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(15.0))),
              child: new InkWell(
                onTap: () {
                  print("tapped " + rando.name);
                  Navigator.pushNamed(context, detailRando, arguments: rando.id);
                },
                child: Column(
                  children: [
                    Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          if( rando.images != null) Container(
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width,
                            child: LoadImage(rando.images[0])
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  const Color(0xCC000000),
                                  const Color(0x00000000),
                                ],
                              ),
                            ),
                          ),
                          Padding(

                            padding: const EdgeInsets.all(12.0),
                            child:  Text(
                              rando.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textScaleFactor: 1,
                              strutStyle: StrutStyle(fontSize: 25),
                              style: TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(16.0))
                        ]),
                    Column(children: [
                      Container(
                        foregroundDecoration: BoxDecoration(
                            border: Border(
                                bottom:
                                BorderSide(width: 10, color: getColor(rando.difficulty))
                            )
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(rando.distance != null) Text(
                                rando.distance.round().toString() + 'km',
                                style: TextStyle(color: Colors.black, fontSize: 25),
                              ),
                              Text(
                                '3h30',
                                style: TextStyle(color: Colors.black, fontSize: 25),
                              ),
                            ],
                          ))
                    ]),
                  ],
                ),
              )
          ),
        )
    );
  }
}

//Return color based on difficulty of the hike
Color getColor(int level) {
  switch(level){
    case 1:
      return Color(0xFF00E676);
    case 2:
      return Color(0xFFFFA000);
    default:
      return Color(0xFFFF8A65);
  }
}
