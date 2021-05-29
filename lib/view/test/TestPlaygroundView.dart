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
import 'TestPlaygroundViewModel.dart';

class TestPlaygroundView extends StatelessWidget {
  Timer timer ;

  MainConfig currentConfig;
  TestPlaygroundView( MainConfig currentConfig , {Key key}) : super(key: key){
    this.currentConfig = currentConfig;
  }
  

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestPlaygroundViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
      body:Column(
        children: [

          FlatButton(onPressed: (){ currentConfig.currentMqttConsumer.mqttSubscribe();}, child: Text("mqtt")),


        ],
      )


      ),
      viewModelBuilder: () => TestPlaygroundViewModel(),
      onModelReady: (model) =>  () {
          print("test");

      });
  }

}

