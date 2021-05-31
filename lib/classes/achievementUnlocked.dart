import 'package:mvvm_flutter_app/network/api-connect.dart';

import '../main.dart';

class AchievementUnlocked{
  final String id;
  final String userId;
  final String achievementId;

  AchievementUnlocked({
    this.id,
    this.userId,
    this.achievementId,
  });

  factory AchievementUnlocked.fromJson(Map<String, dynamic> json){
    return AchievementUnlocked(
        id: json['_id'],
        userId: json['userId'],
        achievementId: json['achievementId'],
    );
  }

  static Future<List<String>> getUserAchievements() async {
    List<String> achievementsUnlocked = [];
    final achievementsUnlockedJson = await fetchRequestParameters('pathpartoutapi.herokuapp.com', 'achievements/get/user', {
      'token': currentConfig.currentToken,
      'userId': currentConfig.currentUser.id,
      //key: value
    });
    for(Map<String, dynamic> element in achievementsUnlockedJson){
      AchievementUnlocked achievement = AchievementUnlocked.fromJson(element);
      achievementsUnlocked.add(achievement.achievementId);
    }
    return achievementsUnlocked;
  }

  static Future<dynamic> unlockAchivement(String achievementId ) async {

    await fetchRequestParameters('pathpartoutapi.herokuapp.com', 'achievements/unlock', {
      'token': currentConfig.currentToken,
      'userId': currentConfig.currentUser.id,
      'achievementId': achievementId.toString()
    });
    return 'onébon';
  }
}