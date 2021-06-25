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
    print(pAchievementsUnlocked);
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
    return Card(

    clipBehavior: Clip.antiAliasWithSaveLayer,
    semanticContainer: true,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(const Radius.circular(15.0))),
    child:Column(
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
                 color: Colors.white,
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
    )
    );
  }
}
