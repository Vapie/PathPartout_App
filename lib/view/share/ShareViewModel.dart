import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/view/share/ShareView.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

class ShareViewModel extends BaseViewModel {
  String header = 'Suivez-moi sur Path Partout !';
  String stats = "Mes statistiques";
  String role = 'Curieuse aguerrie';
  String dist = 'Distance parcourue';
  String kms = 'Kilomètres mensuels';
  String temps = 'Temps passé en montagne';
  String share = 'Partager';

  debug() {
    User.debuguserfetch();
  }
}