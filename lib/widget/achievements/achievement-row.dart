import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/achievement.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';

class AchievementRow extends StatelessWidget {
  Achievement userAchievement;
  List<String> achievementsUnlocked;
  bool achievementIsUnlocked;

  AchievementRow(Achievement pAchievement, List<String> pAchievementsUnlocked,
      {Key key})
      : super(key: key) {
    this.userAchievement = pAchievement;
    this.achievementsUnlocked = pAchievementsUnlocked;

    if (achievementsUnlocked != null) {
      achievementIsUnlocked = achievementsUnlocked.contains(userAchievement.id);
    } else {
      achievementIsUnlocked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (achievementIsUnlocked)
          Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Expanded(
                    child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Image.asset(
                              'assets/picture/logo.png',
                              height: 30,
                              width: 30,
                            ),
                          )
                      ),
                      Expanded(
                          flex: 8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userAchievement.title,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Requiert: " + userAchievement.requires,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )
                            ],
                          ))
                    ],
                  )
                ])),
              ))
        else
          Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              foregroundDecoration: BoxDecoration(
                color: Colors.grey,
                backgroundBlendMode: BlendMode.saturation,
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Expanded(
                    child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Image.asset(
                            'assets/picture/logo.png',
                            height: 35,
                            width: 35,
                          ),
                        )
                      ),
                      Expanded(
                          flex: 9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userAchievement.title,
                                style: TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              Text(
                                "Requiert: " + userAchievement.requires,
                                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                              )
                            ],
                          ))
                    ],
                  )
                ])),
              )

              /*child: Text("non"),*/
              )
      ],
      /*child: Expanded(
          child: Card(
              color: getColor(sortieRando.difficulty),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(15.0))),
              child: new InkWell(
                onTap: () {
                  print("LA DIFF: " + sortieRando);
                  print("tapped " + sortieRando.name);
                  Navigator.pushNamed(context, detailRando, arguments: sortieRando.id);
                },
                child: Column(
                  children: [
                    Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          if( sortieRando.images != null) Container(
                              height: MediaQuery.of(context).size.height * 0.203,
                              width: MediaQuery.of(context).size.width,
                              child: FittedBox(
                                  child: LoadImage(sortieRando.images[0]),
                                  fit: BoxFit.fill
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,

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
                            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                            child:  Text(
                              sortieRando.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textScaleFactor: 1,
                              */ /*strutStyle: StrutStyle(fontSize: 25),*/ /*
                              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(17.0))
                        ]),
                    Column(children: [

                      */ /*Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if(sortieRando.distance != null) Text(
                                sortieRando.distance.round().toString() + 'km',
                                style: TextStyle(color: Colors.black, fontSize: 25),
                              ),
                              Text(
                                '3h30',
                                style: TextStyle(color: Colors.black, fontSize: 25),
                              ),
                            ],
                          ))*/ /*
                    ]),
                  ],
                ),
              )
          ),

        )*/
    );
  }
}
