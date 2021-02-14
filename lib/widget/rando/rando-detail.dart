
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';

class RandoDetail extends StatefulWidget {
  var RandoId;


  RandoDetail(int RandoId, {Key key}) : super(key: key){
    this.RandoId = RandoId;
  }


  @override
  _RandoDetailState createState() => _RandoDetailState();
}

class _RandoDetailState extends State<RandoDetail> {
  Future<Rando> futureRando;



  @override
  void initState() {
    super.initState();
    futureRando = Rando.fetchRando(widget.RandoId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Rando>(
          future: futureRando,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                Text(snapshot.data.name),
                Text(snapshot.data.duration),
                Text(snapshot.data.start_point),
                Text(snapshot.data.difficulty.toString()),
                Text(snapshot.data.pos_elevation.toString()),
                Text(snapshot.data.neg_elevation.toString()),
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
