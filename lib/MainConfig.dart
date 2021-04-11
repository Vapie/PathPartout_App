
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
  String currentToken = "LbPppi52vp0wtselxSXxg0ZayOrEKiVN ";
  String  mapToken = 'pk.eyJ1IjoidmFwaWUiLCJhIjoiY2tpb3BqOWcyMWY2YjJ4cWpvZTd0d3I0cyJ9.MXKDNscpbGFVy1xy1Q6CFg';


  MainConfig(){
    currentUser = new User();
    myrandonotif = new RandoNotif();
    currentRando = new Rando();

  }



}