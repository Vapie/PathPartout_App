import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/network/api-connect.dart';
import 'package:mvvm_flutter_app/network/token.dart';
import 'package:stacked/stacked.dart';

class RegisterViewModel extends BaseViewModel {

  createUser(String email, String password, String confirmPassword) async {
    final newUserJson = await fetchRequestParameters(
        'iutannecy-deptinfo.fr:3000', 'user/create',{
      'token': new Token().getToken(),
      'email': email,
      'password': password
    });
    print(User.fromJson(newUserJson));
    return;
  }

  debug() {
    User.debuguserfetch();
  }
}
