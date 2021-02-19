
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';

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
              return Container(
                child: Column(
                    children: [
                      Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            if( snapshot.data.images != null) Container(
                                height: MediaQuery.of(context).size.height * 0.19,
                                width: MediaQuery.of(context).size.width,
                                child: LoadImage(snapshot.data.images[0])
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
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
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                bottom: 60.0
                              ),
                              child:  Text(
                                snapshot.data.name,
                                textScaleFactor: 1,
                                strutStyle: StrutStyle(fontSize: 25),
                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0,
                                  bottom: 30.0
                              ),
                              child:  Text(
                                "Note : 4,5 / 5",
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )
                          ]),
                      Column(children: [
                        Container(
                          foregroundDecoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                  BorderSide(width: 10, color: Colors.red)
                              )
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children: [
                                      TextButton(
                                        onPressed: null,
                                        child: Text(
                                          "Présentation",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                          ),
                                        ),
                                      )
                                    ]
                                ),
                                Column(
                                    children: [
                                      TextButton(
                                        onPressed: null,
                                        child: Text(
                                          "Photos",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17
                                          ),
                                        ),
                                      )
                                    ]
                                ),
                                Column(
                                    children: [
                                      TextButton(
                                        onPressed: null,
                                        child: Text(
                                          "Avis",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17
                                            )
                                        ),
                                      )
                                    ]
                                ),
                              ],
                            )),
                      ]),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[200],
                            child: Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [

                                            Text(
                                                snapshot.data.name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold
                                                )
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            TextButton(
                                                onPressed: null,
                                                child: Text(
                                                  "Let's Go",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                  ),
                                                ),
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.teal,
                                                )
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.4,
                                      color: Colors.grey,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.layers
                                              ),
                                              Text(
                                                "Distance",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17
                                                )
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              if(snapshot.data.distance != null)
                                                Text(
                                                    snapshot.data.distance.round().toString() + "km"
                                                )
                                              else Text(
                                                  "14km"
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    )
                                  ],
                                ),
                              )
                            ),
                          ),

                        ],
                      ),
                      Column(
                        children: [

                        ],
                      )
                    ],
                  ),
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
