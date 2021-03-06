import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/ui/level.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/media/slide-loadimages.dart';

class RandoTile extends StatelessWidget {
  Rando rando;
  bool isFavorite = false;
  bool isBig = false;

  RandoTile(Rando rando, bool bigTile, {Key key}) : super(key: key) {
    this.rando = rando;
    isFavorite = currentConfig.currentUser.favoris.contains(rando.id);
    isBig = bigTile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.28,
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
                  Navigator.pushNamed(context, detailRando,
                      arguments: rando.id);
                },
                child: Column(
                  children: [
                    Stack(alignment: Alignment.bottomLeft, children: [
                      if (rando.images != null)
                        Container(
                            height: MediaQuery.of(context).size.height * 0.19,
                            width: MediaQuery.of(context).size.width,
                            child: LoadImage(rando.images[0])),
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
                      Container(
                          height: MediaQuery.of(context).size.height * 0.19,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    FavoriteButton(
                                      iconColor: Colors.pinkAccent,
                                      isFavorite: isFavorite,
                                      iconSize: (isBig)?MediaQuery.of(context).size.height * 0.03:MediaQuery.of(context).size.height * 0.05,
                                      iconDisabledColor: Colors.white,
                                      valueChanged: (_isFavorite) {
                                        print('Is Favorite : $_isFavorite');
                                        User.modifyUserFav(
                                            rando.id, _isFavorite);
                                      },
                                    )
                                  ]))),
                      Padding(
                        padding: const EdgeInsets.only(top:14.0, left: 14.0, bottom: 22.0, right: 14.0),
                        child: Text(
                          rando.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textScaleFactor: 1,
                          strutStyle: (isBig)?StrutStyle(fontSize: 14):StrutStyle(fontSize: 20),
                          style: (isBig)?TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold):TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(16.0)),
                    ]),
                    Column(children: [
                      Container(
                        foregroundDecoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 10,
                                    color: getColor(rando.difficulty)))),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (rando.distance != null)
                                Text(
                                  rando.distance.round().toString() + 'km',
                                  style: (isBig)?TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold):TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                                ),
                              Text(
                                (rando.duration/60).toInt().toString()+"h"+(rando.duration%60).toInt().toString(),
                                style: (isBig)?TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold):TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ))
                    ]),
                  ],
                ),
              )),
        ));
  }
}

//Return color based on difficulty of the hike
Color getColor(int level) {
  if (currentConfig.currentUser.userData != null) {
    List<dynamic> currentUserData = currentConfig.currentUser.userData;

    double userLevel = double.parse(currentUserData[0].toString());

    double levelDelta = userLevel - level;

    if (levelDelta > 0.5)
      return Color(0xFF00E676);
    if (levelDelta < -0.5)
      return Color(0xFFFF8A65);
    return Color(0xFFFFA000);
  }
  switch(level){
    case 1:
      return Color(0xFF00E676);
    case 2:
      return Color(0xFFf5cd79);
    case 3:
      return Color(0xFFFF8A65);
    case 4:
      return Color(0xFFe66767);
    case 5:
      return Color(0xFF574b90);
    default:
      return Color(0xFFFFFFFF);
  }
}
