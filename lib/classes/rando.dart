
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
  final List<List<double>> gpx;
  final dynamic start_point;
  final dynamic end_point;
  final double distance;
  final List<dynamic> images;

  Rando(
      {this.id, this.name, this.difficulty, this.duration, this.pos_elevation, this.neg_elevation, this.start_point, this.tags, this.summit, this.gpx, this.end_point, this.images, this.distance});

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
        tags: json['tags'],
        summit: json['summit'],
        gpx: getGpxStringAsArray(json["gpx"].toString()),
        images: json['images'],
        distance: json['distance']
    );
  }

  static List<List<double>> getGpxStringAsArray(String str){
    List<List<double>> finalArray = [];
    if (str.length > 10) {
      var j = str.toString().split("MultiLineString")[1].toString().split(
          "}")[0].split(":")[1].toString();
      var i = j.replaceAll("[", "").replaceAll("]", "")
          .replaceAll(" ", "")
          .split(",");

      int tabindex = 0;
      List<double> temparray = [];
      for (String s in i) {
        tabindex ++;
        temparray.add(double.parse(s));
        if (tabindex % 3 == 0) {
          finalArray.add(temparray);
          temparray = [];
        }
      }
    }
    return finalArray;
  }

  static Future<List<Rando>> fetchRandos() async {
    List<Rando> randos = [];
    final randosJson = await fetchRequestMultiple(
        'iutannecy-deptinfo.fr:3000', 'randonnees');
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    return randos;
  }

  static Future<Rando> fetchRando(int id) async {
    List<Rando> randos = [];
    final randosJson = await fetchRequestMultiple(
        'iutannecy-deptinfo.fr:3000', 'randonnee/'+id.toString());
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    return randos[0];
  }

  static Future<List<Rando>> fetchFilteredRando({ String name = null, int difficulty = null, int durationmax = null,int durationmin = null, List<String> tags = null, double distancemax = null, double distancemin = null}) async {
    List<Rando> finalRandos = [];
    List<Rando> randos = [];
    final tempRandos = await fetchRandos();
    randos = tempRandos;
    if (name != null) {
      for (var rando in randos) {
        if (rando.name.contains(name)) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }

    if (difficulty != null) {
      for (var rando in randos) {
        if (rando.difficulty==difficulty) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }

    if (durationmax != null) {
      for (var rando in randos) {
        if (rando.duration<=durationmax) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }

    if (durationmax != null) {
      for (var rando in randos) {
        if (rando.duration>=durationmin) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }
    if (distancemax != null) {
      for (var rando in randos) {
        if (rando.distance<=distancemax) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }

    if (distancemin != null) {
      for (var rando in randos) {
        if (rando.distance>=distancemin) {
          finalRandos.add(rando);
        }
      }
      randos = finalRandos;
      finalRandos=[];

    }
    if (tags != null){
      for (var tag in tags) {
        for (var rando in randos) {
          if (rando.tags.contains(tag)) {
            finalRandos.add(rando);
          }
        }
        randos = finalRandos;
        finalRandos=[];
      }
    }
    return randos;
  }
}



