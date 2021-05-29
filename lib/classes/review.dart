import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/main.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';


class Review {
  String id;
  String avis;
  int randonneeId;
  String userId;
  double note;
  String imageUrl;

  Review(
      {this.id,
        this.avis,
        this.randonneeId,
        this.userId,
        this.note,
        this.imageUrl
      });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['_id'],
        avis: json['avis'],
        randonneeId: int.parse(json['randonneeId']),
        userId: json['userId'],
        note: double.parse(json['note']),
        imageUrl: json['imageUrl'],
    );
  }

  static Future<List<Review>> fetchReviewsByRando(int randonneeId) async {
    List<Review> reviews = [];
    final reviewsJson = await fetchRequestParameters(
      'pathpartoutapi.herokuapp.com', 'avis/get/randonnee', {
      'token': currentConfig.currentToken,
      'randonneeId': randonneeId.toString()
    });
    if (reviewsJson=="Cette randonnee n'a pas encore d'avis."){
          return null;
    }
    reviewsJson.forEach((element) => reviews.add(Review.fromJson(element)));
    return reviews;
  }

  static createReview(String avis, int randonneeId, String userId, double note,
      {String imageUrl = ''}) async {
    String route = '';

    print(imageUrl);

    if(imageUrl == ''){
      route = 'avis/create';

      final newReviewJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', route, {
        'token': currentConfig.currentToken,
        'avis': avis,
        'randonneeId': randonneeId.toString(),
        'userId': userId,
        'note': note.toString()
      });

      print(newReviewJson.toString());
    }else{
      route = 'avis/create/withimage';
      final newReviewJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', route, {
        'token': currentConfig.currentToken,
        'avis': avis,
        'randonneeId': randonneeId.toString(),
        'userId': userId,
        'note': note.toString(),
        'imageUrl': imageUrl
      });

      print(newReviewJson.toString());
    }


  }
}