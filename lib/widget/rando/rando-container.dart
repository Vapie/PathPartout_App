
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';

class RandoContainer extends StatefulWidget {
  var RandoId;


  RandoContainer(int RandoId, {Key key}) : super(key: key){
    this.RandoId = RandoId;
  }


  @override
  _RandoContainerState createState() => _RandoContainerState();
}

class _RandoContainerState extends State<RandoContainer> {
  Future<Rando> futureRando;



  @override
  void initState() {
    super.initState();
    futureRando = Rando.fetchRando(widget.RandoId);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Data Example'),
      ),
      body: Center(
        child: FutureBuilder<Rando>(
          future: futureRando,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.name);
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
