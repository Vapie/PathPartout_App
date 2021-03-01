
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/ui/level.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/media/slide-loadimages.dart';

class AddRandoTile extends StatelessWidget {



  AddRandoTile( {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Expanded(
          child: Card(

              clipBehavior: Clip.antiAliasWithSaveLayer,
              semanticContainer: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(const Radius.circular(15.0))),

          ),
        )
    );
  }
}

//Return color based on difficulty of the hike
Color getColor(int level) {
  switch(level){
    case 1:
      return Color(0xFF00E676);
    case 2:
      return Color(0xFFFFA000);
    default:
      return Color(0xFFFF8A65);
  }
}
