import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/core/CoreView.dart';
import 'package:mvvm_flutter_app/view/login/LoginView.dart';
import 'package:mvvm_flutter_app/view/plan/PlanView.dart';
import 'package:mvvm_flutter_app/view/profile/ProfileView.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyView.dart';
import 'package:mvvm_flutter_app/view/splash/SplashView.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-detail.dart';

const String core = '/';
const String survey = '/Survey';
const String login = '/Login';
const String detailRando = '/DetailRando';
const String splash = '/splash';
const String profile = '/profile';

const String mapRando = '/MapRando';
// from https://medium.com/flutter-community/clean-navigation-in-flutter-using-generated-routes-891bd6e000df
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case core:
        var data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => CoreView(data: data));
      case detailRando:
        var data = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => RandoDetail(randoId: data));
      case mapRando:
        var data = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => PlanView(randoId: data));
      case survey:
        return MaterialPageRoute(builder: (_) => SurveyView());
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
