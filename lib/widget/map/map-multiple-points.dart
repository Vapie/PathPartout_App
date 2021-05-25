import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import "package:latlong/latlong.dart";
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';

import '../../main.dart';

class MyMapMultiMarkers extends StatefulWidget {
  MyMapMultiMarkers({Key key}) : super(key: key);

  @override
  _MyMapMultiMarkersState createState() => _MyMapMultiMarkersState();
}

class _MyMapMultiMarkersState extends State<MyMapMultiMarkers> {
  List<Rando> randosList;

  @override
  void initState() {
    super.initState();
    randosList = currentConfig.getCurrentRandoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterMap(
                options: new MapOptions(
                  center: new LatLng(45.839, 6.211),
                  zoom: 11.0,
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
                  new MarkerLayerOptions(
                    markers: [
                      for (var element in randosList)
                        if (element.startPoint != null)
                          new Marker(
                            width: 80.0,
                            height: 80.0,
                            point: new LatLng(
                                double.parse(element.startPoint["coordinates"]
                                    .replaceAll(" ", "")
                                    .split(',')[0]),
                                double.parse(element.startPoint["coordinates"]
                                    .replaceAll(" ", "")
                                    .split(',')[1])),
                            builder: (ctx) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, detailRando,
                                    arguments: element.id);
                              },
                              child: Icon(Icons.room_rounded,
                                  size: 80.0, color: Colors.red),
                            ),
                          ),
                    ],
                  )
                ],
              )
        )
     );
   }
}
