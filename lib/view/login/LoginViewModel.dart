import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';
import 'package:mvvm_flutter_app/network/token.dart';
import 'package:stacked/stacked.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  authenticate(String email, String password) async {
    final login = await fetchRequestParameters(
      'pathpartoutapi.herokuapp.com', 'user/login', {
      'token': new Token().getToken(),
      'email': email,
      'password': password
    });
    print(login);
  }


}
