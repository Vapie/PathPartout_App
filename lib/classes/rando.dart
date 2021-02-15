import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';

class Rando {
  final int id;
  final String name;
  final int difficulty;
  final int duration;
  final int pos_elevation;
  final int neg_elevation;
  final List<dynamic> tags;
  final int summit;
  final dynamic gpx;
  final dynamic start_point;
  final dynamic end_point;
  final double distance;
  final List<dynamic> images;

  Rando({this.id,this.name,this.difficulty,this.duration,this.pos_elevation,this.neg_elevation,this.start_point,this.tags,this.summit, this.gpx, this.end_point, this.images, this.distance});

  factory Rando.fromJson(Map<String, dynamic> json) {
    return Rando(
      id: json['id'],
      name: json['name'],
      difficulty: json['difficulty'],
      duration: json['duration'],
      pos_elevation: json['pos_elevation'],
      neg_elevation: json['neg_elevation'],
      start_point: json['start_point'],
      end_point: json['end_point'],
      tags : json['tags'],
      summit: json['summit'],
      gpx: json['gpx'],
      images: json['images'],
      distance: json['distance']
    );
  }

  static Future<List<Rando>> fetchRandos() async{
    List<Rando> randos = [];
    final randosJson = await fetchRequestMultiple('iutannecy-deptinfo.fr:3000','randonnees');
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    return randos;
  }

  static Future<Rando> fetchRando(int id) async{
    final randoJson = await fetchRequestSingle('iutannecy-deptinfo.fr:3000','randonnee/'+id.toString());
    return Rando.fromJson(randoJson);
  }
}



