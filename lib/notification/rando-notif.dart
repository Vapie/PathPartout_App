import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/rando/RandoView.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';

import '../main.dart';

class RandoNotif extends StatefulWidget {
  List<dynamic> currentRandoData = ["0", "00:00"];
  RandoNotif({Key key}) : super(key: key) {}

  Podometre mypodometre = new Podometre();
  Timer mytimer = new Timer(Duration(seconds: 1000), () {});

  @override
  _RandoNotifState createState() => _RandoNotifState();

  int randoNotifChannel = 0;

  void pushRandoNotif(String NomRando, int stepNumber, String heure) async {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip =
        new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android, IOS);
    flip.initialize(settings, onSelectNotification: (String payload) async {
      Navigator.defaultRouteName; // your call back to the UI
    });
    // appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id', 'name', 'description',
        importance: Importance.Low,
        priority: Priority.Low,
        playSound: false,
        color: Colors.lightBlueAccent,
        onlyAlertOnce: true);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    flip.show(
        randoNotifChannel,
        NomRando,
        'Nombre de pas :    ' + stepNumber.toString() + "  Heure : " + heure,
        platformChannelSpecifics,
        payload: 'none');
  }

  void deleteRandoNotif() {
    new FlutterLocalNotificationsPlugin().cancel(randoNotifChannel);
  }

  Timer launchRando() {
    this.mypodometre.steps = 0;

    const oneSec = const Duration(seconds: 1);
    String str;
    currentRandoData = ["0", "00:00"];
    var timer = new Timer.periodic(
        oneSec,
        (Timer t) => {
              str = Duration(seconds: t.tick).toString(),
              currentRandoData = [
                this.mypodometre.steps,
                str.substring(0, str.length - 7)
              ],
              pushRandoNotif("RANDONING", this.mypodometre.steps,
                  str.substring(0, str.length - 7))
            });
    this.mytimer = timer;
  }

  void randoStop() {
    String str;
    str = Duration(seconds: this.mytimer.tick).toString();
    print(str.substring(0, str.length - 7) + this.mypodometre.steps.toString());
    this.mytimer.cancel();
    deleteRandoNotif();
  }
}

/// This is the private State class that goes with MyStatefulWidget.
class _RandoNotifState extends State<RandoNotif> {
  int _currentindex = 0;
  Timer _currentTimer;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: _currentindex == 0
            ? MediaQuery.of(context).size.height * 0.28
            : MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(const Radius.circular(15.0))),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  //etat rando
                  if (_currentindex == 0)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                      currentConfig.currentRando.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                      overflow: TextOverflow.ellipsis,
                                  )
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 150,
                                  child: GradientButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Icon(
                                            Icons.run_circle_outlined,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Let's go",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )
                                      ],
                                    ),
                                    onPressed: () {
                                      widget.launchRando();
                                      const oneSec = const Duration(seconds: 1);
                                      _currentindex = 1;

                                      Sortie.fetchSorties();

                                      _currentTimer = new Timer.periodic(
                                          oneSec,
                                          (Timer t) => {
                                                setState(() {}),
                                              });
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            // Difficulté
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.layers),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Difficulté",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: getDifficulty(currentConfig
                                                .currentRando.difficulty))
                                      ],
                                    ),
                                  ],
                                )),
                            // Distance
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.directions),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Distance",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text('14 km'))
                                      ],
                                    ),
                                  ],
                                )),
                            // Durée
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.timer),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Durée",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text(currentConfig
                                                    .currentRando.duration
                                                    .toString() +
                                                " min"))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),

                  // etat randdo en cours
                  if (_currentindex == 1)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Text(
                                  currentConfig.currentRando.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                  overflow: TextOverflow.ellipsis,
                                )
                            ),
                            Container(
                                width: 110,
                                child: GradientButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.home,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Stop",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    ],
                                  ),
                                  onPressed: () {
                                    // on arrête la rando

                                    _currentindex = 2;
                                    enregistrerando();
                                    _currentTimer.cancel();
                                    widget.randoStop();
                                    Navigator.pushNamed(context, feedBack);
                                  },
                                )),
                          ],
                        ),
                        Column(
                          children: [
                            // Distance
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.pets),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Nombre de pas",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text(widget
                                                .currentRandoData.first
                                                .toString()))
                                      ],
                                    ),
                                  ],
                                )),
                            // Durée
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.timer),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Temps",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text(widget
                                                .currentRandoData.last
                                                .toString()))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ],
                    ),

                  if (_currentindex == 2) Text("Rando terminée"),
                ],
              ),
            )));
  }

  void enregistrerando() {
    print("onenregistre");
    Sortie.createSortie(widget.currentRandoData.toString());
    print("cfaita");
  }
}
