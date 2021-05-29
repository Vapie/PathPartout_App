import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/core/CoreView.dart';
import 'package:mvvm_flutter_app/view/dashboard/DashboardView.dart';
import 'package:mvvm_flutter_app/view/feedback/FeedbackView.dart';
import 'package:mvvm_flutter_app/view/loading/LoadingView.dart';
import 'package:mvvm_flutter_app/view/login/LoginView.dart';
import 'package:mvvm_flutter_app/view/plan/PlanView.dart';
import 'package:mvvm_flutter_app/view/profile/ProfileView.dart';
import 'package:mvvm_flutter_app/view/qrcode%20scanner/QrCodeScanView.dart';
import 'package:mvvm_flutter_app/view/rando/RandoView.dart';
import 'package:mvvm_flutter_app/view/register/RegisterView.dart';
import 'package:mvvm_flutter_app/view/feedback/FeedbackView.dart';
import 'package:mvvm_flutter_app/view/review/ReviewView.dart';
import 'package:mvvm_flutter_app/view/sorties/SortiesView.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyView.dart';
import 'package:mvvm_flutter_app/view/splash/SplashView.dart';
import 'package:mvvm_flutter_app/view/share/ShareView.dart';
import 'package:mvvm_flutter_app/view/test/TestPlaygroundView.dart';
import 'package:mvvm_flutter_app/view/editProfil/editProfilView.dart';

import '../main.dart';

const String core = '/';
const String survey = '/Survey';
const String login = '/Login';
const String detailRando = '/DetailRando';
const String splash = '/splash';
const String profile = '/profile';
const String qr = '/qr';
const String loading = '/qr';
const String editionProfil = '/editProfil';


const String share = '/share';
const String register = '/Register';
const String testPlayground = '/TestPlayground';
const String mapRando = '/MapRando';
const String feedBack = '/FeedBack';
const String review = '/Review';
const String sorties = '/Sorties';
const String dashboard = '/Dashboard';

// from https://medium.com/flutter-community/clean-navigation-in-flutter-using-generated-routes-891bd6e000df
class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case core:
        var data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => CoreView(data: data));
      case loading:
        var data = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => LoadingView(data : data));
      case qr:
        return MaterialPageRoute(builder: (_) => QRCodeScanView());
      case detailRando:
        var data = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => RandoView(randoId: data));
      case mapRando:
        var data = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => PlanView(currentConfig: currentConfig, randoId : data));
      case survey:
        return MaterialPageRoute(builder: (_) => SurveyView());
      case testPlayground:
        return MaterialPageRoute(builder: (_) => TestPlaygroundView(currentConfig));
      case login:
        return MaterialPageRoute(builder: (_) => LoginView());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterView());
      case splash:
        return MaterialPageRoute(builder: (_) => SplashView());
      case profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case share:
        return MaterialPageRoute(builder: (_) => ShareView());
      case feedBack:
        return MaterialPageRoute(builder: (_) => FeedbackView());
      case review:
        return MaterialPageRoute(builder: (_) => ReviewView());
      case sorties:
        return MaterialPageRoute(builder: (_) => SortiesView());
      case dashboard:
        return MaterialPageRoute(builder: (_) => DashboardView());
      case editionProfil:
        return MaterialPageRoute(builder: (_) => editProfilView());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
