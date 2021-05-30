import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class RegisterViewModel extends BaseViewModel {
  createUser(String email, String password, String confirmPassword,String pseudo) async {
      User.createUser(email, password,pseudo);
  }
}