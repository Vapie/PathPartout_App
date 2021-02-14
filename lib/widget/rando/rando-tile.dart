
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-detail.dart';

class RandosContainer extends StatefulWidget {


  RandosContainer( {Key key}) : super(key: key);


  @override
  _RandosContainerState createState() => _RandosContainerState();
}

class _RandosContainerState extends State<RandosContainer> {
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
              return Column(children:[
                for ( var element in snapshot.data ) RandoTile()
              ]);
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
