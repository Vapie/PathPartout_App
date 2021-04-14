import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';
import 'package:mvvm_flutter_app/widget/sorties/sortie-tile.dart';

class SortiesWrapper extends StatelessWidget {
  List<Sortie> sorties;
  SortiesWrapper() {}
  Future<List<Sortie>> getSorties() async {
    //TODO remove this
    await User.authenticate("v@v.fr", "v@v.v");
    sorties = await Sortie.getUserSorties();
    return sorties;
  }

  @override
  Widget build(context) {
    return FutureBuilder<List<Sortie>>(
        future: getSorties(),
        builder: (context, AsyncSnapshot<List<Sortie>> snapshot) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 60),
                    child: Text("Mes dernières randos",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20.0),
                    height: 170.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (var i = 0; i <  snapshot.data.length; i++)
                          SortieTile( snapshot.data[i].randonnee ),
                      ],
                    ),
                  )
                ]);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
