import 'package:flutter/cupertino.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';
import '../main.dart';
class Rando {
  final int id;
  final String name;
  final int difficulty;
  final int duration;
  final int posElevation;
  final int negElevation;
  final List<dynamic> tags;
  final int summit;
  final List<List<double>> gpx;
  final dynamic startPoint;
  final dynamic endPoint;
  final double distance;
  final List<dynamic> images;

  Rando(
      {this.id,
      this.name,
      this.difficulty,
      this.duration,
      this.posElevation,
      this.negElevation,
      this.startPoint,
      this.tags,
      this.summit,
      this.gpx,
      this.endPoint,
      this.images,
      this.distance});

  factory Rando.fromJson(Map<String, dynamic> json) {
    if (json['distance'] ==  null){
    return Rando(
        id: json['id'],
        name: json['name'],
        difficulty: json['difficulty'],
        duration: json['duration'],
        posElevation: json['pos_elevation'],
        negElevation: json['neg_elevation'],
        startPoint: json['start_point'],
        endPoint: json['end_point'],
        tags: json['tags'],
        summit: json['summit'],
        gpx: getGpxStringAsArray(json["gpx"].toString()),
        images: json['images']);

  }
    else
      return Rando(
          id: json['id'],
          name: json['name'],
          difficulty: json['difficulty'],
          duration: json['duration'],
          posElevation: json['pos_elevation'],
          negElevation: json['neg_elevation'],
          startPoint: json['start_point'],
          endPoint: json['end_point'],
          tags: json['tags'],
          summit: json['summit'],
          gpx: getGpxStringAsArray(json["gpx"].toString()),
          images: json['images'],
          distance: double.parse(json['distance'].toString()));
  }

  static List<List<double>> getGpxStringAsArray(String str) {
    List<List<double>> finalArray = [];
    if (str.length > 10) {
      var j = str
          .toString()
          .split("MultiLineString")[1]
          .toString()
          .split("}")[0]
          .split(":")[1]
          .toString();
      var i = j
          .replaceAll("[", "")
          .replaceAll("]", "")
          .replaceAll(" ", "")
          .split(",");

      int tabindex = 0;
      List<double> temparray = [];
      for (String s in i) {
        tabindex++;
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
    final randosJson =
        await fetchRequestMultiple('pathpartoutapi.herokuapp.com', 'randonnees');
    print(randosJson);
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    return randos;
  }

  static Future<Rando> fetchRando(int id) async {
    List<Rando> randos = [];
    final randosJson = await fetchRequestMultiple(
        'pathpartoutapi.herokuapp.com', 'randonnee/' + id.toString());
    print(randosJson);
    randosJson.forEach((element) => randos.add(Rando.fromJson(element)));
    currentConfig.currentRando = randos[0];
    return randos[0];
  }

  static Future<List<Rando>> fetchFilteredRando(
      {String name = null,
      int difficulty = null,
      int durationmax = null,
      int durationmin = null,
      List<String> tags = null,
      double distancemax = null,
      double distancemin = null}) async {
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
      finalRandos = [];
    }

    if (difficulty != null) {
      for (var rando in randos) {
        if (rando.difficulty != null) {
          if (rando.difficulty == difficulty) {
            finalRandos.add(rando);
          }
        }
      }
      randos = finalRandos;
      finalRandos = [];
    }

    if (durationmax != null) {
      for (var rando in randos) {
        if (rando.duration != null) {
          if (rando.duration <= durationmax) {
            finalRandos.add(rando);
          }
        }
      }
      randos = finalRandos;
      finalRandos = [];
    }

    if (durationmax != null) {
      for (var rando in randos) {
        if (rando.duration != null) {
          if (rando.duration >= durationmin) {
            finalRandos.add(rando);
          }
        }
      }
      randos = finalRandos;
      finalRandos = [];
    }
    if (distancemax != null) {
      for (var rando in randos) {
        if (rando.distance != null) {
          if (distancemax >= rando.distance) {
            finalRandos.add(rando);
          }
        }
      }
      randos = finalRandos;
      finalRandos = [];
    }

    if (distancemin != null) {
      for (var rando in randos) {
        if (rando.distance != null) {
          if (rando.distance >= distancemin) {
            finalRandos.add(rando);
          }
        }
      }
      randos = finalRandos;
      finalRandos = [];
    }

    if (tags != null) {
      for (var tag in tags) {
        for (var rando in randos) {
          if (rando.tags.contains(tag)) {
            finalRandos.add(rando);
          }
        }
        randos = finalRandos;
        finalRandos = [];
      }
    }
    return randos;
  }
}
