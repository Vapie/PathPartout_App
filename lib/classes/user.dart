import 'package:flutter/cupertino.dart';
import 'package:mvvm_flutter_app/main.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';


class User {
  String id;
  String firstname;
  String lastname;
  String mail;
  String photoUrl;
  int privilegeLevel;
  List<dynamic> avatar;
  List<dynamic> userData;

  User(
      {this.id,
        this.firstname,
        this.lastname,
        this.mail,
        this.photoUrl,
        this.privilegeLevel,
        this.avatar,
        this.userData
      });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        mail: json['mail'],
        photoUrl: json['photoUrl'],
        privilegeLevel: json['privilegeLevel'],
        avatar: json['avatar'],
        userData: json['userData']
    );
  }

  static Future<User> fetchUser(String id) async {
    List<User> users = [];
    final usersJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'user/get',{
          'token': currentConfig.currentToken,
          'userId': id
    });
    usersJson.forEach((element) => users.add(User.fromJson(element)));
    return users[0];
  }

  static Future<User> authenticate(String email, String password) async {
    final login = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'user/login', {
      'token': currentConfig.currentToken,
      'email': email,
      'password': password
    });
    print(login);
    var user =  await User.fetchUser(login["userId"]);
    user.id = login["userId"];
    print(user.id);
    currentConfig.currentUser = user;
    currentConfig.currentToken = login["token"];

  }
}
 // TODO