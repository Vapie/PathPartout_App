import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/register/register_view_model.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/media/outlined-gradient-button.dart';
import 'package:stacked/stacked.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
    builder: (context, model, child) => Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text("Login Page"),
      // ),
      body:
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
          Column(
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
            padding: EdgeInsets.only(top: 20.0),
            child: Text('Inscription',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20)),
          ),

          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Entrez votre email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirmer le mot de passe',
                  hintText: 'Entrez votre mot de passe'),
            ),
          ),

          // Bouton invité
          Container(
              height: 50,
              width: 250,
              margin: EdgeInsets.only(top: 30.0),
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: OutlinedGradientButton(
                children: Text(
                  "S'inscrire",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                onPressed: () {
                  model.createUser(emailController.text, passwordController.text, confirmPasswordController.text);
                },
              )),
        ],
      ),
    ),
      viewModelBuilder: () => RegisterViewModel(),
      //onModelReady: (model) => model.debug(),
    );
  }
}
