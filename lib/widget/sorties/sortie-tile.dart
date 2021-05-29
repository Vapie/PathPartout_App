
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/ui/level.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/media/slide-loadimages.dart';

class SortieTile extends StatelessWidget {
  var sortieRando;


  SortieTile(Rando sortie, {Key key}) : super(key: key){
    this.sortieRando = sortie;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Expanded(
            child: Card(
              color: getColor(sortieRando.difficulty),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(const Radius.circular(15.0))),
                child: new InkWell(
                  onTap: () {
                    print("LA DIFF: " + sortieRando);
                    print("tapped " + sortieRando.name);
                    Navigator.pushNamed(context, detailRando, arguments: sortieRando.id);
                  },
                  child: Column(
                    children: [
                      Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            if( sortieRando.images != null) Container(
                                height: MediaQuery.of(context).size.height * 0.203,
                                width: MediaQuery.of(context).size.width,
                                child: FittedBox(
                                    child: LoadImage(sortieRando.images[0]),
                                    fit: BoxFit.fill
                                )
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.1,

                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    const Color(0xCC000000),
                                    const Color(0x00000000),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                              child:  Text(
                                sortieRando.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textScaleFactor: 1,
                                /*strutStyle: StrutStyle(fontSize: 25),*/
                                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.all(17.0))
                          ]),
                    ],
                  ),
                )
            ),

        )
    );
  }
}
//Return color based on difficulty of the hike
Color getColor(int level) {
  print(level);
  switch(level){
    case 1:
      return Color(0xFF00E676);
    case 2:
      return Color(0xFFf5cd79);
    case 3:
      return Color(0xFFFF8A65);
    case 4:
      return Color(0xFFe66767);
    case 5:
      return Color(0xFF574b90);
    default:
      return Color(0xFFFFFFFF);
  }
}
