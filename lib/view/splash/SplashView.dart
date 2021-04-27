import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/splash/SplashViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: GestureDetector(
            onTap: (){Navigator.pushNamed(context, survey);},
            child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FractionallySizedBox(

                  widthFactor: 0.3,
                  child: Image.asset(
                    'assets/picture/logo.png',
                  ),
                ),

          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                   "",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 25

                    )
                ),
              ]
            )
          ),
          ),
      ])))),
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (model) => Future.delayed(const Duration(milliseconds: 3000), () {
          Navigator.pushNamed(context, login);
      }),
    );
  }
}

