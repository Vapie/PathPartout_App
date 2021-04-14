import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:mvvm_flutter_app/main.dart';

import 'ReviewViewModel.dart';

class ReviewView extends StatefulWidget {

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  double rating = 2;
  Map review = {};
  final reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<ReviewViewModel>.reactive(
        builder: (context, model, child) =>
            Scaffold(
                body: Container(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [
                            Color(0xFF2AB7F6),
                            Color(0xFF5EC8F8),
                            Color(0xFFCAE67B)
                          ],
                          stops: [0, 0.2, 1],
                          center: Alignment(1, 2),
                          focal: Alignment.bottomRight,
                          focalRadius: 2
                      )
                  ),
                  child: Center(
                      child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 40, right: 40, top: 60, bottom: 40),
                                child: Column(
                                    children: [
                                      Text(
                                          model.header,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              color: Colors.white
                                          )
                                      ),
                                      SizedBox(height: 25),
                                      Text(
                                          model.heading,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w300
                                          )
                                      ),
                                      SizedBox(height: 50),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  "Note",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                      color: Colors.white
                                                  )
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 10.0),
                                                    child: Text(
                                                      "${rating.toString()}/5",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 17.0
                                                      ),
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: rating,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                                    itemBuilder: (context, _) => Icon(
                                                      Icons.brightness_1_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    updateOnDrag: true,
                                                    onRatingUpdate: (currentRating) {
                                                      setState(() {
                                                        rating = currentRating;
                                                      });
                                                    },
                                                    itemSize: 20.0,
                                                  )
                                                ],
                                              )
                                            ],
                                          )

                                        ],
                                      ),
                                      SizedBox(height: 30),
                                      Row(
                                        children: [
                                          Text(
                                              "Description",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                  color: Colors.white
                                              )
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      TextField(
                                        controller: reviewController,
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                            hintText: "Ce que j'ai pensé de la randonnée.."
                                        ),
                                      ),

                                      SizedBox(height: 50),
                                      OutlinedButton(
                                        child: Text('Continuer'),
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.lightBlue,
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10))),
                                        ),
                                        onPressed: () {
                                          review.addAll({'avis': reviewController.text, 'note': rating});
                                          model.store(review);
                                          Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRando.id);
                                        },
                                      ),

                                      OutlinedButton(
                                        child: Text('Annuler'),
                                        style: OutlinedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10)),
                                          ),
                                          side: BorderSide(
                                            color: Colors.white
                                          )
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRando.id);
                                        },
                                      ),
                                    ]
                                )
                            ),
                          ]
                      )
                  ),
                )
            ),
        viewModelBuilder: () => ReviewViewModel(),
        onModelReady: (model) => {
        }
    );
  }
}