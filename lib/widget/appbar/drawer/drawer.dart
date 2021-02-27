import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/media/difficulty-filter.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/media/slider-range.dart';

class AppDrawer extends StatelessWidget {
  final nameController = TextEditingController();

  var _currentSliderValue = 5.0;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.grey[200],
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: [
                Container(
                    child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    "Recherche manuelle",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                )),
                Container(
                  padding: EdgeInsets.only(top: 20.0),
                  child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Nom...',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.lightGreen)))),
                ),
                // Filtre de distance
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text("Distance",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold))),
                ),
                FilterSlider(),

                // Filtre de difficulté
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text("Difficulté",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold))),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: DifficultyFilter(),
                ),

                // Submit button
                Align(
                  alignment: Alignment.bottomRight,
                  child: GradientButton(
                    child: Text(
                      "Rechercher",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0
                      ),
                    ),
                    gradient: LinearGradient(
                        colors: [
                          Colors.lightBlue,
                          Colors.lightGreenAccent[100]
                        ]
                    ),
                    width: MediaQuery.of(context).size.width * 0.4,
                    onPressed: () async {
                      final List<Rando> futureRandos =
                      await Rando.fetchFilteredRando(
                          name: nameController.text,
                          distancemin: _currentSliderValue,
                      );
                      Navigator.pushNamed(context, core, arguments: {
                        "selectedIndex": 0,
                        "randosCollection": futureRandos,
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
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
