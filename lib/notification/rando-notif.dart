import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';


class RandoNotif extends StatefulWidget {
  dynamic currentRandoData = {0,"00:00"};

  RandoNotif( {Key key}) : super(key: key) {}

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

    var timer = new Timer.periodic(oneSec, (Timer t) => {
      str = Duration(seconds: t.tick).toString(),
      currentRandoData = {this.mypodometre.steps,str.substring(0, str.length - 7)},
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
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlatButton(onPressed: (){ print("a");/*widget.launchRando()*/}, child: Text(widget.currentRandoData.toString()))
      ],
    );
  }

}
/*


*/