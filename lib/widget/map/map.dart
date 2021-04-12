import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong/latlong.dart";

import 'package:mvvm_flutter_app/classes/rando.dart';

import '../../main.dart';

class MyMap extends StatefulWidget {
  var randoId;

  MyMap(int randoId, {Key key}) : super(key: key) {
    this.randoId = randoId;
  }

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Future<Rando> futureRando;

  @override
  void initState() {
    super.initState();
    futureRando = Rando.fetchRando(widget.randoId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Rando>(
          future: futureRando,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new FlutterMap(
                options: new MapOptions(
                  center: new LatLng(
                      snapshot.data.gpx[0][1], snapshot.data.gpx[0][0]),
                  zoom: 13.0,
                ),
                layers: [
                  new TileLayerOptions(
                    urlTemplate: "https://api.tiles.mapbox.com/v4/"
                        "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
                      'accessToken': currentConfig.mapToken,
                      'id': 'mapbox.satellite',
                    },
                  ),
                  PolylineLayerOptions(polylines: [
                    Polyline(
                      points: [
                        for (var element in snapshot.data.gpx)
                          new LatLng(element[1], element[0])
                      ],
                      isDotted: true,
                      color: Color(0xFF669DF6),
                      strokeWidth: 3.0,
                      borderColor: Color(0xFF1967D2),
                      borderStrokeWidth: 0.1,
                    )
                  ]),
                  new MarkerLayerOptions(
                    markers: [
                      new Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new LatLng(
                            snapshot.data.gpx[0][1], snapshot.data.gpx[0][0]),
                        builder: (ctx) => new Container(
                          child: Icon(Icons.room_rounded,
                              size: 80.0, color: Colors.red),
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
