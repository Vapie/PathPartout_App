
import 'package:mvvm_flutter_app/view/feedback/FeedbackView.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';

import 'classes/rando.dart';
import 'classes/user.dart';
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


  MainConfig(){
    currentUser = new User();
    myrandonotif = new RandoNotif();
    currentRando = new Rando();
  }

   List<Rando> getCurrentRandoList(){
      return  currentRandoList;
  }
  void getRandoList() async {
    currentRandoList = await Rando.fetchProfileSortedRando();
  }





}