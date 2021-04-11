import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/view/randos/RandosViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/rando/addrando-tile.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';
import 'package:stacked/stacked.dart';

class RandosView extends StatelessWidget {
  List<Rando> randos;

  RandosView(List<Rando> randos, {Key key}) : super(key: key) {
    this.randos = randos;
    print(randos);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandosViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Scaffold(
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
                          for (var i = 0; i < randos.skip(1).length; i++)
                            if (i % 2 == 1) RandoTile(randos[i + 1]),
                          if (randos.length % 2 == 0) AddRandoTile(),
                        ],
                      ),
                      Column(
                        //TODO maybeviewmodel
                        children: [
                          for (var i = 0; i < randos.skip(1).length; i++)
                            if (i % 2 == 0) RandoTile(randos[i + 1]),
                        ],
                      )
                    ],
                  )
                ],
              );
            })())),
          ),
          appBar: myAppBar(),
          endDrawer: AppDrawer()),
      viewModelBuilder: () => RandosViewModel(),
    );
  }
}
