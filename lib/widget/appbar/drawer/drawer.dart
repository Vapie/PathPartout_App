import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';

class AppDrawer extends StatelessWidget {
  final nameController = TextEditingController();

  var _currentSliderValue= 0.0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Text("Recherche manuelle"),
          TextField(  controller: nameController, decoration: const InputDecoration( hintText: 'Nom...', )),
          Align(alignment: AlignmentDirectional.topStart,child: Text("Distance", style: TextStyle(fontSize: 20.0))),
          FlatButton(
          child: Text('Valider', style: TextStyle(fontSize: 20.0),),
          onPressed: () async {
            final List<Rando> futureRandos = await Rando.fetchFilteredRando(name:nameController.text);
           Navigator.pushNamed(context, core, arguments: {"selectedIndex": 0,"randosCollection" : futureRandos });
          },
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}