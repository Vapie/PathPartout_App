import 'package:mvvm_flutter_app/network/api-connect.dart';

class Achievement{
  final String id;
  final String title;
  final String requires;
  final String reward;

  Achievement({
    this.id,
    this.title,
    this.requires,
    this.reward
  });

  factory Achievement.fromJson(Map<String, dynamic> json){
    return Achievement(
      id: json['_id'],
      title: json['title'],
      requires: json['requires'],
      reward: json['reward']
    );
  }

  static Future<List<Achievement>> getAchievements() async {
    List<Achievement> achievements = [];
    final achievementsJson =
    await fetchRequestMultiple('pathpartoutapi.herokuapp.com', 'achievements/list');
    for(Map<String, dynamic> element in achievementsJson){
      Achievement achievement = Achievement.fromJson(element);
      achievements.add(achievement);
    }
    return achievements;
  }

}