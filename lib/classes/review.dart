import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/main.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';


class Review {
  String id;
  String avis;
  int randonneeId;
  String userId;
  double note;

  Review(
      {this.id,
        this.avis,
        this.randonneeId,
        this.userId,
        this.note
      });



  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        id: json['_id'],
        avis: json['avis'],
        randonneeId: json['randonneeId'],
        userId: json['userId'],
        note: json['note'],
    );
  }

  static Future<Review> fetchReview(String id) async {
    List<Review> users = [];
    final usersJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'user/get',{
      'token': currentConfig.currentToken,
      'userId': id
    });
    usersJson.forEach((element) => users.add(Review.fromJson(element)));
    return users[0];
  }

  static createReview(String avis, int randonneeId, String userId, double note) async {
    final newReviewJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'avis/create', {
      'token': currentConfig.currentToken,
      'avis': avis,
      'randonneeId': randonneeId,
      'userId': userId,
      'note': note,
    });
  }
}