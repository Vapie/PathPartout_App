import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';
import 'package:mvvm_flutter_app/widget/sorties/sortie-tile.dart';

class SortiesWrapper extends StatelessWidget {
  List<Sortie> sorties;
  SortiesWrapper() {}
  Future<List<Sortie>> getSorties() async {
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
                  Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                        ),
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
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
