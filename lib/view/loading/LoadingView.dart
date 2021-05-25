import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/notification/rando-notif.dart';
import 'package:mvvm_flutter_app/view/splash/SplashViewModel.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';
import 'package:stacked/stacked.dart';

class LoadingView extends StatelessWidget {
  LoadingView({Map data}) {
    Function func = data["asyncFunc"];
    func.call();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.white,body:Center(child: CircularProgressIndicator()));
  }


}

