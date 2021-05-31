import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/achievement.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/widget/achievements/achievement-row.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

class AchievementsWrapper extends StatelessWidget {
  List<Achievement> achievements;
  List<Achievement> sortedAchievements = [];
  SortiesWrapper() {}
  Future<List<Achievement>> getAchievements() async {
    achievements = await Achievement.getAchievements();
    //(achievements);
    await getAchievementsUnlocked();
    sortedAchievements = await achievementsSorter(achievements);
    return sortedAchievements;
  }

  List<String> achievementsUnlocked;
  Future<List<String>> getAchievementsUnlocked() async {
    achievementsUnlocked = await AchievementUnlocked.getUserAchievements();
    return achievementsUnlocked;
  }

  Future<List<Achievement>> achievementsSorter(pAchievements) async {
    for(var i=0; i < pAchievements.length; i++){
      if(achievementsUnlocked.contains(pAchievements[i].id)){
        sortedAchievements.insert(0, pAchievements[i]);
      }
      else{
        sortedAchievements.add(pAchievements[i]);
      }
    }
    return sortedAchievements;
  }

  @override
  Widget build(context) {
    return FutureBuilder<List<Achievement>>(
        future: getAchievements(),
        builder: (context, AsyncSnapshot<List<Achievement>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE),
                    ),
                    height: MediaQuery.of(context).size.height - 84,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text("Succès", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
                        ),
                        for (var i = 0; i <  snapshot.data.length; i++)
                          AchievementRow( snapshot.data[i], achievementsUnlocked),
                      ],
                    ),
                  )
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
