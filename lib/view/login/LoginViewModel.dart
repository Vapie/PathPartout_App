import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:mvvm_flutter_app/network/token.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  var token = new Token().safeStore();

  newstring() {
    return "login un max ";
  }




}

