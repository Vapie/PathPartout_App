
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';

class RandoTile extends StatelessWidget {
  var rando;


  RandoTile(Rando rando, {Key key}) : super(key: key){
    this.rando = rando;
  }



  @override
  Widget build(BuildContext context) {
    return Column(children: [
                Text(rando.name),
                if( rando.images!=null)
                    LoadImage(rando.images[0])

              ],
        );
  }
}
