import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

class Rando {
  final int id;
  final String name;
  final int difficulty;
  final int duration;
  final int pos_elevation;
  final int neg_elevation;
  final String start_point;
  final List<dynamic> tags;

  Rando({this.id,this.name,this.difficulty,this.duration,this.pos_elevation,this.neg_elevation,this.start_point,this.tags});

  factory Rando.fromJson(Map<String, dynamic> json) {
    return Rando(
      id: json['id'],
      name: json['name'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      pos_elevation: json['pos_elevation'],
      neg_elevation: json['neg_elevation'],
      start_point: json['start_point'],
      tags : json['tags']
    );
  }

  static Future<List<Rando>> fetchRandos() async{
    List<Rando> randos = [];
    final randosJson = await fetchRequestMultiple('iutannecy-deptinfo.fr:3000','randonnees');
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    return randos;
  }

  static Future<Rando> fetchRando(int id) async{
    final randos = await fetchRandos();
    return randos.singleWhere((element) => element.id == id);

  }
}



