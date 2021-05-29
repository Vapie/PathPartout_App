
import 'package:mvvm_flutter_app/view/feedback/FeedbackView.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';

import 'classes/avatar.dart';
import 'classes/rando.dart';
import 'classes/user.dart';
import 'network/BaliseMqttConsumer.dart';
import 'notification/rando-notif.dart';
/// This is the stateful widget that the main application instantiates.
///
class MainConfig {
  User currentUser;
  RandoNotif myrandonotif;
  Rando currentRando;
  String currentToken = "LbPppi52vp0wtselxSXxg0ZayOrEKiVN";
  String  mapToken = 'pk.eyJ1IjoidmFwaWUiLCJhIjoiY2tpb3BqOWcyMWY2YjJ4cWpvZTd0d3I0cyJ9.MXKDNscpbGFVy1xy1Q6CFg';
  List<Rando> currentRandoList;
  MqttConsumer currentMqttConsumer;
  List<MqttBaliseMessage>  currentBaliseList=[];
  Avatar currentAvatar;

  MainConfig(){
    currentUser = new User();
    myrandonotif = new RandoNotif();
    currentRando = new Rando();
    currentMqttConsumer =new MqttConsumer();
    currentAvatar = new Avatar();
  }

   List<Rando> getCurrentRandoList(){
      return  currentRandoList;
  }
  void getRandoList() async {
    currentRandoList = await Rando.fetchProfileSortedRando();
  }





}