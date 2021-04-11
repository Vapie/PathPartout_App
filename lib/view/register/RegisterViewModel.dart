import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';
import 'package:stacked/stacked.dart';

import '../../main.dart';

class RegisterViewModel extends BaseViewModel {
  createUser(String email, String password, String confirmPassword) async {
    final newUserJson = await fetchRequestParameters(
        'pathpartoutapi.herokuapp.com', 'user/create', {
      'token': currentConfig.currentToken,
      'email': email,
      'password': password
    });
    print(newUserJson);

  }

  debug() {
    //User.debuguserfetch();
  }
}