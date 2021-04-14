import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/user.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';
import '../main.dart';
class Sortie {
  final String id;
  final int randonneeId;
  final String userId;
  final DateTime date;
  final Rando randonnee;
  final User user;

  Sortie(
      {this.id,
      this.randonneeId,
      this.userId,
      this.date,
      this.randonnee,
      this.user
      });

  factory Sortie.fromJson(Map<String, dynamic> json) {
    return Sortie(
        id: json['_id'],
        randonneeId: json['randonneeId'],
        userId: json['userId'],
        date: DateTime.parse(json['date']),
        randonnee: Rando.fromJson(json['randonnee'][0]),
        user: User.fromJson(json['user'][0]));
  }



  static Future<List<Sortie>> fetchSorties() async {

    List<Sortie> sorties = [];
    final sortiesJson =
        await fetchRequestMultiple('pathpartoutapi.herokuapp.com', 'sortie/all');
    sortiesJson.forEach((element) => sorties.add(Sortie.fromJson(element)));
    return sorties;
  }

  static Future<List<Sortie>> getUserSorties() async {
    List<Sortie> sorties = [];
    final sortiesJson =
    await fetchRequestMultiple('pathpartoutapi.herokuapp.com', 'sortie/all');
    for(Map<String, dynamic> element in sortiesJson){
      Sortie sortie = Sortie.fromJson(element);
      if (sortie.userId.toString() == currentConfig.currentUser.id.toString()){
        sorties.add(sortie);
      }
    }
    return sorties;
  }

  static void createSortie(String performances) async {
    final rep =
    await fetchRequestParameters('pathpartoutapi.herokuapp.com', 'sortie/create', {
      'token': currentConfig.currentToken,
      'randonneeId': currentConfig.currentRando.id.toString(),
      'userId': currentConfig.currentUser.id,
      'performances': performances
    });
  }



}
