
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'classes/rando.dart';
import 'classes/user.dart';
import 'notification/rando-notif.dart';
/// This is the stateful widget that the main application instantiates.
///
class MainConfig {
  User currentUser;
  RandoNotif myrandonotif;
  Rando currentRando;
  MainConfig(){
    currentUser = new User();
    myrandonotif = new RandoNotif();
    currentRando = new Rando();
  }



}