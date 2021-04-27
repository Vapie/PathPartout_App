import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvvm_flutter_app/classes/review.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/widget/media/gallery-loadimages.dart';
import 'package:mvvm_flutter_app/widget/media/loadimage.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';

// ignore: must_be_immutable
class RandoView extends StatefulWidget {
  int randoId;

  RandoView({Key key, int randoId}) : super(key: key) {
    this.randoId = randoId;
  }

  @override
  _RandoViewState createState() => _RandoViewState();
}

class _RandoViewState extends State<RandoView> {
  List<Review> _reviews;
  Future<Rando> futureRando;
  List<Rando> futureRandos;
  final presentationKey = new GlobalKey();
  final photoKey = new GlobalKey();
  final reviewKey = new GlobalKey();
  double rating = 2;

  getRandos() async {
    futureRandos = await Rando.fetchRandos();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    Navigator.pushNamed(context, core,
        arguments: {"selectedIndex": 0, "randosCollection": futureRandos});
    return true;
  }

  @override
  void initState() {
    super.initState();
    futureRando = startAsyncInit();
    BackButtonInterceptor.add(myInterceptor);
  }

  Future<Rando> startAsyncInit() async {
    _reviews = await Review.fetchReviewsByRando(currentConfig.currentRando.id);
    futureRando = Rando.fetchRando(widget.randoId);
    getRate();
    return await futureRando;
  }

  getRate() {
    if(_reviews != null) {
      rating =
          _reviews.map((m) => m.note).reduce((a, b) => a + b) / _reviews.length;
      return rating;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      endDrawer: AppDrawer(),
      body: Center(
        child: FutureBuilder<Rando>(
          future: startAsyncInit(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(children: [
                Stack(alignment: Alignment.bottomLeft, children: [
                  if (snapshot.data.images != null)
                    Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width,
                        child: LoadImage(snapshot.data.images[0])),
                  // dégradé sur l'image
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
                  Positioned(
                    top: 10,
                    right: 10,
                    child: TextButton(
                      onPressed: () {
                        print(widget.randoId);
                        Navigator.pushNamed(context, review);
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: getColor(snapshot.data.difficulty),
                        onSurface: Colors.grey,
                      ),
                      child: Text(
                        "Ajouter un avis",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 60.0),
                    child: Text(
                      snapshot.data.name,
                      textScaleFactor: 1,
                      strutStyle: StrutStyle(fontSize: 25),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 30.0),
                    child: Text(
                      "Note : 4,5 / 5",
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ]),
                Column(children: [
                  Container(
                    foregroundDecoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 10,
                                color: getColor(snapshot.data.difficulty)))),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            TextButton(
                              onPressed: () => Scrollable.ensureVisible(
                                  presentationKey.currentContext),
                              child: Text(
                                "Présentation",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            )
                          ]),
                          Column(children: [
                            TextButton(
                              onPressed: () => Scrollable.ensureVisible(
                                  photoKey.currentContext),
                              child: Text(
                                "Photos",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            )
                          ]),
                          Column(children: [
                            TextButton(
                              onPressed: () => Scrollable.ensureVisible(
                                  reviewKey.currentContext),
                              child: Text("Avis",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            )
                          ]),
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
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10.0, bottom: 5.0),
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: new Column(
                                        key: presentationKey,
                                        children: <Widget>[
                                          new Text(snapshot.data.name,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    TextButton(
                                        onPressed: () => {
                                              Navigator.pushNamed(
                                                  context, mapRando,
                                                  arguments: snapshot.data.id)
                                            },
                                        child: Text(
                                          "Let's Go",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            // Difficulté
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.layers),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Difficulté",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: getDifficulty(
                                                snapshot.data.difficulty))
                                      ],
                                    ),
                                  ],
                                )),
                            // Distance
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.directions),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Distance",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text('14 km'))
                                      ],
                                    ),
                                  ],
                                )),
                            // Durée
                            Padding(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(Icons.timer),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Text("Durée",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17)),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                            padding:
                                                EdgeInsets.only(right: 10.0),
                                            child: Text(snapshot.data.duration
                                                    .toString() +
                                                " min"))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      )),
                    ),
                    Column(children: [
                      // Photos
                      Row(
                        children: [
                          Padding(
                              key: photoKey,
                              padding: EdgeInsets.all(20.0),
                              child: Text("Photos",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (snapshot.data.images != null)
                            GalleryLoadImage(
                                snapshot.data.images,
                                MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.height * 0.2)
                          else
                            Container(
                                padding: EdgeInsets.only(left: 20.0),
                                child: Text(
                                    "Il n'y a aucune image.. N'hésitez pas à en ajouter !",
                                    style: TextStyle(color: Colors.grey[600])))
                        ],
                      ),
                      // Avis - En-tête
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                  key: reviewKey,
                                  padding: EdgeInsets.all(20.0),
                                  child: Text("Avis",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Row(
                                    children: [
                                      RatingBar.builder(
                                        initialRating: rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.brightness_1_rounded,
                                          color: Colors.lightBlueAccent,
                                        ),
                                        updateOnDrag: false,
                                        onRatingUpdate: (currentRating) {
                                          setState(() {
                                            rating = currentRating;
                                          });
                                        },
                                        itemSize: 20.0,
                                      ),
                                      Text(" $rating / 5",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                      // Avis - Utilisateurs
                      if (_reviews != null)
                        for (var review in _reviews)
                          //for (var i = 0; i < 2; i++)
                          Container(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: AssetImage(
                                            "assets/picture/portrait.jpg"),
                                      ),
                                    ]),
                                    // Avis - Description

                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 0,
                                                                  right: 10.0),
                                                          child: Text(
                                                              "utilisateur anonyme",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)))
                                                    ],
                                                  ),
                                                  Column(children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Text(
                                                        "Curieuse aguerrie",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  const Radius
                                                                          .circular(
                                                                      15.0)),
                                                          color:
                                                              Colors.red[300]),
                                                    ),
                                                  ])
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.75,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        new Text(review.avis,
                                                            textAlign:
                                                                TextAlign.left)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              color: Colors.grey[200])
                    ])
                  ],
                ),
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

//Return text based on difficulty of the hike
Text getDifficulty(int level) {
  switch (level) {
    case 1:
      return Text("Facile",
          style:
              TextStyle(color: getColor(level), fontWeight: FontWeight.bold));
    case 2:
      return Text("Intermédiaire",
          style:
              TextStyle(color: getColor(level), fontWeight: FontWeight.bold));
    default:
      return Text("Avancée",
          style:
              TextStyle(color: getColor(level), fontWeight: FontWeight.bold));
  }
}
