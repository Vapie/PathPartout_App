
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

class RandosList extends StatefulWidget {

  RandosList( {Key key}) : super(key: key);


  @override
  _RandosListState createState() => _RandosListState();
}

class _RandosListState extends State<RandosList> {
  Future<List<Rando>> futureRandos;



  @override
  void initState() {
    super.initState();
    futureRandos = Rando.fetchRandos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Rando>>(
          future: futureRandos,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                       children:[ Expanded(child:
                           FittedBox(
                             fit: BoxFit.fitWidth,
                             child: RandoTile(snapshot.data.elementAt(0)),
                            )
                       ) ]
                    )
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          for ( var element in snapshot.data.skip(1)) RandoTile(element),
                        ],
                      )
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
