import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';
import '../main.dart';

class RandoNotif extends StatefulWidget {
  List<dynamic> currentRandoData = ["0","00:00"];
  RandoNotif({Key key}) : super(key: key) {}

  Podometre mypodometre = new Podometre();
  Timer mytimer = new Timer( Duration(seconds:1000),(){});


  @override
  _RandoNotifState createState() => _RandoNotifState();




  int randoNotifChannel = 0;

  void  pushRandoNotif(String NomRando,int stepNumber, String heure) async {
    // initialise the plugin of flutterlocalnotifications.
    FlutterLocalNotificationsPlugin flip = new FlutterLocalNotificationsPlugin();

    // app_icon needs to be a added as a drawable
    // resource to the Android head project.
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();

    // initialise settings for both Android and iOS device.
    var settings = new InitializationSettings(android, IOS);
    flip.initialize(settings,  onSelectNotification: (String payload) async {
      Navigator.defaultRouteName;    // your call back to the UI
    });
    // appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'id',
        'name',
        'description',
        importance: Importance.Low,
        priority: Priority.Low,
        playSound :false,
        color:Colors.lightBlueAccent,
        onlyAlertOnce:true
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();

    // initialise channel platform for both Android and iOS device.
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics
    );

    flip.show(randoNotifChannel,NomRando,
        'Nombre de pas :    '   + stepNumber.toString() + "  Heure : " + heure    ,
        platformChannelSpecifics, payload: 'none'
    );
  }

  void deleteRandoNotif(){

    new FlutterLocalNotificationsPlugin().cancel(randoNotifChannel);
  }

  Timer launchRando() {
    this.mypodometre.steps = 0;

    const oneSec = const Duration(seconds:1);
    String str;
    currentRandoData = ["0","00:00"];
    var timer = new Timer.periodic(oneSec, (Timer t) => {
      str = Duration(seconds: t.tick).toString(),
      currentRandoData = [this.mypodometre.steps,str.substring(0, str.length - 7)],
      pushRandoNotif("RANDO TEST",this.mypodometre.steps,str.substring(0, str.length - 7))

    });
    this.mytimer = timer;

  }

  void randoStop(){

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
    return Row(
      children: [
        //etat rando
        if (_currentindex == 0)FlatButton(onPressed: (){
          widget.launchRando();
        const oneSec = const Duration(seconds:1);
          _currentindex = 1;


          Sortie.fetchSorties();

          _currentTimer = new Timer.periodic(oneSec, (Timer t) => {
            setState(() {}),

          });
        },
        child: Text("démarer la rando")
        ),
        // etat randdo en cours
        if (_currentindex == 1)FlatButton(onPressed: (){
          // on arrète la rando

            _currentindex = 2;
            enregistrerando();
            _currentTimer.cancel();
            widget.randoStop();
            Navigator.pushNamed(context, feedBack);
            },
            child: Text("stop rando")

        ),
        if (_currentindex == 2)Text("Rando terminée"),

        if (_currentindex == 1)Text("Nombre de pas:" + widget.currentRandoData.first.toString() + " Temps : " + widget.currentRandoData.last.toString()),
      ],
    );

  }

  void  enregistrerando() {
    print("onenregistre");
    Sortie.createSortie(widget.currentRandoData.toString());
    print("cfaita");

  }
}