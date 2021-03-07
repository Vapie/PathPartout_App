import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/view/splash/SplashView.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/media/outlined-gradient-button.dart';
import 'package:stacked/stacked.dart';
import '../../widget/rando/rando-detail.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body: SingleChildScrollView(
        // Background ok avec container sinon pixel overflowed bottom
        // decoration: BoxDecoration(
        //     gradient: RadialGradient(
        //         colors: [Color(0xFF2AB7F6), Color(0xFF5EC8F8), Color(0xFFCAE67B)],
        //         stops: [0, 0.2, 1],
        //         center: Alignment(1, 2),
        //         focal: Alignment.bottomRight,
        //         focalRadius: 2
        //     )
        // ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    margin: const EdgeInsets.only(bottom: 30.0),
                    child: Image.asset('assets/picture/logo.png', height: 90)),
              ),
            ),
            Text('Path Partout'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 25)),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Entrez votre email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mot de passe',
                    hintText: 'Entrez votre mot de passe'),
              ),
            ),

            FlatButton(
              onPressed: () {
                // TODO
              },
              child: Text(
                'Mot de passe oublié',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
            ),

            // Container(
            //   height: 50,
            //   width: 250,
            //   margin: const EdgeInsets.only(bottom: 10.0),
            //   decoration: BoxDecoration(
            //       color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            //   child: FlatButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => SplashView()));
            //     },
            //     child: Text(
            //       'Se connecter',
            //       style: TextStyle(color: Colors.white, fontSize: 25),
            //     ),
            //   ),
            // ),

            // Bouton de connexion
            Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: GradientButton(
                  child: Text(
                    "Se connecter",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                )),

            FlatButton(
              onPressed: () {
                Navigator.pushNamed(context, register);
              },
              child: Text(
                "Pas de compte ? C'est par ici !",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    decoration: TextDecoration.underline),
              ),
            ),

            // Bouton invité
            Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(bottom: 80.0),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: OutlinedGradientButton(
                  children: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Mode invité",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.grey)),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(
                            Icons.wb_sunny,
                            color: Colors.grey,
                          ))
                    ],
                  ),
                  onPressed: () {
                    print("tapped ");
                    Navigator.pushNamed(context, detailRando);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
