import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/view/login/LoginView.dart';

import 'package:mvvm_flutter_app/view/plan/PlanView.dart';
import 'package:mvvm_flutter_app/view/planmultiple/PlanMultipleView.dart';
import 'package:mvvm_flutter_app/view/profile/ProfileView.dart';
import 'package:mvvm_flutter_app/view/randos/RandosView.dart';

// Si on navigue ici, il faut renseigner randosCollection au minimum
class MyNavigationBar extends StatefulWidget {
  Map data;
  MyNavigationBar(Map data, {Key key}) : super(key: key) {
    this.data = data;
  }

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState(data);
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  List<Rando> randos;
  List<Widget> _options;

  _MyNavigationBarState(Map data) {
    if(data!=null) {
      _selectedIndex = data["selectedIndex"];
      if (data.containsKey("randosCollection")) {
        randos = data["randosCollection"];
      } else {
        //TODO remove final
        print("Il faut ajouter randosCollection sur la nav vers core ");
      }
    }

    _options = <Widget>[
      RandosView(randos),
      PlanMultipleView(),
      ProfileView(),
    ];
  }
  void _onItemTap(int index) {
    _options = <Widget>[
      RandosView(randos),
      PlanMultipleView(),
      ProfileView(),
    ];
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.filter_hdr_outlined),
                label: 'Randos',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                label: 'Map',
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          iconSize: 40,
          onTap: _onItemTap,
          elevation: 5),
    );
  }
}
