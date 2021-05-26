import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/media/outlined-gradient-button.dart';
import 'package:stacked/stacked.dart';

List<Rando> futureRandos;
getRandos() async {
  futureRandos = await currentConfig.getCurrentRandoList();
}

class LoginView extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              // appBar: AppBar(
              //   title: Text("Login Page"),
              // ),
              body: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 150,
                            margin: const EdgeInsets.only(bottom: 30.0),
                            child: Image.asset('assets/picture/logo.png',
                                height: 90)),
                      ),
                    ),
                    Text('Path Partout'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 25)),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: TextField(
                        controller: emailController,
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
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mot de passe',
                            hintText: 'Entrez votre mot de passe'),
                      ),
                    ),

                    TextButton(
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
                          onPressed: () async {

                            //on créé une fonction asynchrone qui permet de l'envoyer dans la page de loading
                            Future<void> asyncFunc() async {
                              await User.authenticate(emailController.text, passwordController.text);
                              await currentConfig.getRandoList();
                              if ((currentConfig.currentUser.userData != null) & (currentConfig.currentUser.userData.toString() != "[]"))
                                    //Navigator.pushNamed(context, core, arguments: { "selectedIndex": 0, "randosCollection": currentConfig.getCurrentRandoList()});
                                Navigator.pushNamed(context, dashboard);

                              if ((currentConfig.currentUser.userData == null)|| (currentConfig.currentUser.userData.toString() == "[]"))
                                    Navigator.pushNamed(context, survey);
                            }
                            // on part sur la page de loading avec la fonction embarquée
                            Navigator.pushNamed(context, loading, arguments: { "asyncFunc": asyncFunc});


                          },
                        )),

                    TextButton(
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
                    // Container(
                    //     height: 50,
                    //     width: 250,
                    //     alignment: Alignment.bottomRight,
                    //     decoration: BoxDecoration(
                    //         color: Colors.blue,
                    //         borderRadius: BorderRadius.circular(20)),
                    //     child: OutlinedGradientButton(
                    //       children: Row(
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Text("Mode invité",
                    //               style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 25,
                    //                   color: Colors.grey)),
                    //           Padding(
                    //               padding: EdgeInsets.only(left: 20.0),
                    //               child: Icon(
                    //                 Icons.wb_sunny,
                    //                 color: Colors.grey,
                    //               ))
                    //         ],
                    //       ),
                    //       onPressed: () async {
                    //         await getRandos();
                    //         if ((currentConfig.currentUser.userData != null) & (currentConfig.currentUser.userData.toString() != "[]"))
                    //           Navigator.pushNamed(context, core, arguments: { "selectedIndex": 0, "randosCollection": futureRandos });
                    //         if ((currentConfig.currentUser.userData == null)|| (currentConfig.currentUser.userData.toString() == "[]"))
                    //           Navigator.pushNamed(context, survey);
                    //       },
                    //     )),
                  ],
                ),
              ),
            ),
        viewModelBuilder: () => LoginViewModel());
  }
}
