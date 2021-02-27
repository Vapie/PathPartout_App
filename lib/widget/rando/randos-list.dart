import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

class RandosList extends StatelessWidget {
  List<Rando> randos = [];

  RandosList(List<Rando> randos, {Key key}) : super(key: key) {
    this.randos = randos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ((() {
        print(randos);
        if (randos.length == 0) {
          return Text("Aucune randonnée disponible :(");
        }

        return ListView(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: RandoTile(randos.elementAt(0)),
                      ))
                    ])),
            Row(
              children: [
                Column(
                  children: [
                    //TODO maybe viewmodel
                    for (var i=0;i < randos.skip(1).length; i++ ) if (i%2 == 1 )  RandoTile(randos[i+1]),
                  ],
                ),
                Column(
                  //TODO maybeviewmodel
                  children: [
                    for (var i=0;i < randos.skip(1).length; i++ ) if (i%2 == 0 )  RandoTile(randos[i+1]),
                  ],
                )
              ],
            )
          ],
        );
      })())),
    );
  }
}
