import 'package:flutter/cupertino.dart';

import 'package:mvvm_flutter_app/network/api-connect.dart';
import 'package:mvvm_flutter_app/network/token.dart';

class User {
  final String id;
  final String firstname;
  final String lastname;
  final String mail;
  final String photoUrl;
  final int privilegeLevel;
  final List<dynamic> avatar;
  final List<dynamic> userData;

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
          'token': new Token().getToken(),
          'userId': id
    });
    usersJson.forEach((element) => users.add(User.fromJson(element)));
    return users[0];
  }

  static debuguserfetch() async {
   final user  = await User.fetchUser("603517e4ef23520af406fc46");
   print(user);
  }
}
