import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
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
                    child: Image.asset( 'assets/picture/logo.png',
                      height: 90)),
              ),
            ),
            Text(
                'Path Partout'.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 25
                )
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your Email'),
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
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            FlatButton(
              onPressed: (){
                // TODO
              },
              child: Text(
                'Mot de passe oublié',
                style: TextStyle(color: Colors.blue, fontSize: 15),
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
      // Submit button
      Container(
        height: 50,
        width: 250,
          margin: const EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: GradientButton(
          child: Text(
            "Se connecter",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          gradient: LinearGradient(colors: [
            Colors.lightBlue,
            Colors.lightGreenAccent[100]
          ]),
        )),
            // Submit button
            Container(
                height: 50,
                width: 250,
                margin: const EdgeInsets.only(bottom: 80.0),
                alignment: Alignment.bottomRight,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: GradientButton(
                  child: Text(
                    "Mode invité",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.lightBlue,
                    Colors.lightGreenAccent[100]
                  ]),
                )),

            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}