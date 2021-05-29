import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mvvm_flutter_app/classes/achievement.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
import 'package:mvvm_flutter_app/classes/user.dart';

import 'package:mvvm_flutter_app/classes/sorties.dart';

import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/profile/ProfileView.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

class DashboardTile extends StatelessWidget {
  var type;
  var height;
  var title;

  DashboardTile(String type, double height, String title, {Key key})
      : super(key: key) {
    this.type = type;
    this.height = height;
    this.title = title;
  }

  var boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.3),
    spreadRadius: 2,
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  dynamic performancesData;


  Future<dynamic> getSortiesData() async {

    double nbKm = 0;
    double min = 0;

    double heure = 0;
    List<int> NbPas = [0,0,0,0,0,0,0,0,0,0,0,0];
    List<Sortie> sorties = await Sortie.getUserSorties();

    int currentmonth =  DateTime.now().month;

    for(Sortie sortie in sorties) {
      if(sortie.randonnee.distance != null){
        nbKm = nbKm+ sortie.randonnee.distance;
      }

      if(sortie.performances != null){

        // nbKm = nbKm+ sortie.randonnee.distance;
        List<String> SplittedHeure = sortie.performances[1].split(":");
        heure += int.parse(SplittedHeure[0]) + int.parse(SplittedHeure[1])/60;
        min += int.parse(SplittedHeure[1]) + int.parse(SplittedHeure[2])/60;

        if (sortie.date.difference(DateTime.now())<Duration(days: 365)){

          NbPas[sortie.date.month-1] += sortie.randonnee.distance.toInt();

        }
      }
    }


    List<String> MonthLabel=["Jan","Fev","Mar","Avr","Mai","Jun","Jul","Aou","Sep","Oct","Nov","Dec"];
    List<Dist> tabpas = [Dist(MonthLabel[(currentmonth-6)%12],NbPas[(currentmonth-6)%12]),
      Dist(MonthLabel[(currentmonth-5)%12],NbPas[(currentmonth-5)%12]),
      Dist(MonthLabel[(currentmonth-4)%12],NbPas[(currentmonth-4)%12]),
      Dist(MonthLabel[(currentmonth-3)%12],NbPas[(currentmonth-3)%12]),
      Dist(MonthLabel[(currentmonth-2)%12],NbPas[(currentmonth-2)%12]),
      Dist(MonthLabel[(currentmonth-1)%12],NbPas[(currentmonth-1)%12])];

    performancesData = {"nbKm":nbKm.round(),"tempsTot":(heure + min/60 ).round().toString() +" h "+ (min%60).round().toString() + "min","LastPost":tabpas};
    return performancesData;
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
    if (type == "achievement") {
      return FutureBuilder<List<Achievement>>(
          future: getAchievements(),
          builder: (context, AsyncSnapshot<List<Achievement>> snapshot) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * height,
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                        children: [
                          Text(
                              "Succès \ndéverrouillés", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
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
                              achievementsUnlocked.length.toString() + '/' +
                                  achievements.length.toString(),
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

    if (type == "rando") {
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
            boxShadow: [boxShadow],
          ),
          child: Expanded(
            child: Column(
                children: [
                  Stack(alignment: Alignment.bottomLeft, children: [
                    if (currentConfig.currentRandoList[0].images != null)
                      Container(
                          child: LoadImage(
                              currentConfig.currentRandoList[0].images[0])),
                    Container(
                      height:
                      MediaQuery.of(context).size.height * height,
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
                      child: Text(
                        currentConfig.currentRandoList[0].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textScaleFactor: 1,
                        strutStyle: StrutStyle(fontSize: 25),
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRandoList[0].id);
                          },
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xFFFF8A65),
                      ),
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Text("Conseillée pour vous",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500)),
                    ))
                  ]),
                ],
              ),
            ),
          );
    }

    if (type == "qrcode") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Icon(
              Icons.qr_code_scanner,
              size: 80,
              color: Colors.white,
            )
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [boxShadow],
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

    if (type == "performances") {
      return Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              )),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFFFF8A65),
                      boxShadow: [boxShadow],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Distance totale",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            //TODO
                            '12 km',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        GradientText(
                          text: "Mes randos",
                          colors: <Color>[
                            Color(0xFF2AB7F6),
                            Color(0xFF5EC8F8),
                            Color(0xFFCAE67B)
                          ],
                          gradientDirection: GradientDirection.ltr,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          margin: EdgeInsets.only(top: 10),
                          child: GradientText(
                            //TODO
                            text: "3",
                            colors: <Color>[
                              Color(0xFF2AB7F6),
                              Color(0xFF5EC8F8),
                              Color(0xFFCAE67B)
                            ],
                            gradientDirection: GradientDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xFF5EC8F8),
                      boxShadow: [boxShadow],
                    ),
                    child: Column(children: [
                      Text(
                        "Mes pas",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          //TODO
                          '50 000',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ]),
                  ),
                ]),
          )
        ]),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [boxShadow],
        ),
      );
    }

    if (type == "profil") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage('assets/picture/portrait.jpg'),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Lauren, 32 ans",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xFFFF8A65),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Text("Curieuse aguerrie",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, profile);
                  },
                  child: Icon(
                    Icons.chevron_right_rounded,
                    size: 80,
                    color: Colors.grey,
                  ),
                )
              ],
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
          boxShadow: [boxShadow],
        ),
      );
    }

    if (type == "pub") {
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
          boxShadow: [boxShadow],
        ),
      );
    }
  }
}
