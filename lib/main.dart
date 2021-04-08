import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'locator.dart';
import 'navigation/routes.dart' as navRoute;

MainConfig currentConfig = new MainConfig();

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  configure();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: navRoute.Router.generateRoute,
      initialRoute: navRoute.login,
    ));
  }
//Navigator.pushNamed(context, secondScreenRoute, arguments: 'Data from home');

}


