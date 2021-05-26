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
  List<int> favoris;

  User({this.id,
        this.firstname,
        this.lastname,
        this.mail,
        this.photoUrl,
        this.privilegeLevel,
        this.avatar,
        this.userData,
        this.favoris
      });

  factory User.fromJson(Map<String, dynamic> json) {
    var currentFav = [];
    if (json.keys.contains("favoris"))
      currentFav = User.parseFavoris(json["favoris"]);

    return User(
          id: json['_id'],
          firstname: json['firstname'],
          lastname: json['lastname'],
          mail: json['mail'],
          photoUrl: json['photoUrl'],
          privilegeLevel: json['privilegeLevel'],
          avatar: json['avatar'],
          userData: User.recoveruserData(json['userData'].toString()),
          favoris: currentFav
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
    //TODO add redirect to login page with alert if not logged in.
    var user =  await User.fetchUser(login["userId"]);
    user.id = login["userId"];
    currentConfig.currentToken = login["token"];
    currentConfig.currentUser = user;
  }

  static createUser(String email, String password) async {
    final newUserJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'user/create', {
      'token': currentConfig.currentToken,
      'email': email,
      'password': password
    });
    User.authenticate(email, password);

  }

  static modifyCurrentUser(String key, String value) async {
    return(await fetchRequestParametersPut(
        'pathpartoutapi.herokuapp.com', 'user/update', {
      'token': currentConfig.currentToken,
      'id':currentConfig.currentUser.id,
      key: value
    }));
  }

  static modifyUserFav(int randoId, bool isAddRando) async {
    if (isAddRando && !currentConfig.currentUser.favoris.contains(randoId)) {
      currentConfig.currentUser.favoris.add(randoId);
    }

    if (!isAddRando && currentConfig.currentUser.favoris.contains(randoId)) {
      currentConfig.currentUser.favoris.remove(randoId);
    }
    await modifyCurrentUser("favoris",currentConfig.currentUser.favoris.toString());
  }

  static modifyCurrentUserData(String userData) async {
    await modifyCurrentUser("userData",userData);
  }

  static List<dynamic> recoveruserData(dynamic obj) {
      if (obj != null && obj != "null") {
        String str = obj as String;
        List<String> userDataList =  str.substring(1, str.length - 1).split(",");
        String taglist="";

        for (var i = 2; i < userDataList.length; i++) {
            taglist += userDataList[i].toString() +",";
        }
        return [userDataList[0],userDataList[1],taglist.substring(0, taglist.length - 1)];

      }
      List<dynamic> l;
      return l;
  }

  static List<int> parseFavoris(String str) {
    List<int> currentFav = [];
    List<String> splitedData =  str.substring(1, str.length - 1).split(",");


    for (var i = 0; i < splitedData.length; i++) {
      currentFav.add(int.parse(splitedData[i]));
    }
    return currentFav;
  }
}