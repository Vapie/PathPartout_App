import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong/latlong.dart";
import 'package:mvvm_flutter_app/network/token.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';

class MyMapMultiMarkers extends StatefulWidget {


  MyMapMultiMarkers({Key key}) : super(key: key) { }

  @override
  _MyMapMultiMarkersState createState() => _MyMapMultiMarkersState();
}

class _MyMapMultiMarkersState extends State<MyMapMultiMarkers> {
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

              print(snapshot.data);
              return new FlutterMap(
                options: new MapOptions(
                  // center: new LatLng(
                  //     snapshot.data, snapshot.data.gpx[0][0]),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://api.tiles.mapbox.com/v4/"
                        "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken': new Token().getMapToken(),
                      'id': 'mapbox.satellite',
                    },
                  ),
                 new MarkerLayerOptions(
                    markers: [ for ( var element in snapshot.data ) if(element.start_point!=null) new Marker(
                                        width: 80.0,
                                        height: 80.0,
                                        point: new LatLng(
                                            double.parse(element.start_point["coordinates"].replaceAll(" ","").split(',')[0]),double.parse(element.start_point["coordinates"].replaceAll(" ","").split(',')[1])),
                                        builder: (ctx) => new Container(
                                          child:  Icon(Icons.room_rounded, size: 80.0 , color: Colors.red),
                                        ),
                                      ),
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
