import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/achievement.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

class DashboardTile extends StatelessWidget {
  var type;
  var height;
  var title;

  DashboardTile(String type, double height, String title, {Key key}) : super(key: key){
    this.type = type;
    this.height = height;
    this.title = title;
  }

  List<Achievement> achievements;
  List<Achievement> sortedAchievements = [];
  Future<List<Achievement>> getAchievements() async {
    achievements = await Achievement.getAchievements();
    print(achievements);
    await getAchievementsUnlocked();
    return achievements;
  }

  List<String> achievementsUnlocked;
  Future<List<String>> getAchievementsUnlocked() async {
    achievementsUnlocked = await AchievementUnlocked.getUserAchievements();
    return achievementsUnlocked;
  }

  Widget build(BuildContext context) {
    if(type == "achievement") {
      return FutureBuilder<List<Achievement>>(
          future: getAchievements(),
          builder: (context, AsyncSnapshot<List<Achievement>> snapshot) {
            return Container(
              height: MediaQuery.of(context).size.height * height,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                        child:Row(
                            children: [
                              Text(
                                  "Succès déverrouillés"
                              ),
                            ]
                        ),
                    ),
                    Expanded(
                      flex: 9,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                achievementsUnlocked.length.toString() + '/' + achievements.length.toString(),
                                style: TextStyle(fontSize: 40),
                                textAlign: TextAlign.center,
                              ),
                            ]
                        )
                    )
                  ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            );
      });
    }

    if(type == "rando") {
      return Container(
          height: MediaQuery.of(context).size.height * height,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: new InkWell(
            onTap: () {
              print("tapped " + currentConfig.currentRandoList[0].name);
              Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRandoList[0].id);
            },
            child: Column(
              children: [
                Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      if( currentConfig.currentRandoList[0].images != null) Container(
                          height: MediaQuery.of(context).size.height * (height - 0.05),
                          width: MediaQuery.of(context).size.width,
                          child: LoadImage(currentConfig.currentRandoList[0].images[0])
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * (height - 0.05),
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
                          currentConfig.currentRandoList[0].name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textScaleFactor: 1,
                          strutStyle: StrutStyle(fontSize: 25),
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(12.0))
                    ]),
                Column(children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 10, color: getColor(currentConfig.currentRandoList[0].difficulty))
                        )
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if(currentConfig.currentRandoList[0].distance != null) Text(
                            currentConfig.currentRandoList[0].distance.round().toString() + 'km',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                          Text(
                            '3h30',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ))
                ]),
              ],
            ),
          )
      );
    }

    if(type == "qrcode") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(
            title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.lightBlueAccent,
              Colors.lightGreenAccent[200],
            ],
          ),
        ),
      );
    }

    if(type == "performances") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(
            title
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "profil"){
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "pub"){
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

  }
}
