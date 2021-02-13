import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/core/CoreView.dart';
import 'package:mvvm_flutter_app/view/login/LoginView.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyView.dart';

const String core = '/';
const String survey = '/Survey';
const String login = '/Login';


// from https://medium.com/flutter-community/clean-navigation-in-flutter-using-generated-routes-891bd6e000df
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case core:
        return MaterialPageRoute(builder: (_) => CoreView() );
      case survey:
        return MaterialPageRoute(builder: (_) => SurveyView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}