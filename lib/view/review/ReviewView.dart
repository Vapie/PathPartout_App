import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:stacked/stacked.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_flutter_app/network/api-connect.dart';

import 'ReviewViewModel.dart';

class ReviewView extends StatefulWidget {

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  double rating = 2;
  Map review = {};
  final reviewController = TextEditingController();
  PickedFile _image;
  String _imageUrl;
  String key = 'db1aab6984c441f66e92dbb18799853b';

  _sendImage(model) async {
    String url = 'api.imgbb.com';
    String path = '1/upload';

    http.Response res = await http.post(
      Uri.https(url, path),
      body: {
        'image': base64Encode(File(_image.path).readAsBytesSync()),
        'key': key,
      }
    );

    if(res.statusCode == 200){
      Map<String, dynamic> response = jsonDecode(res.body);
      print(response);
      _imageUrl = response['data']['url'];

      review.addAll({'avis': reviewController.text, 'note': rating, 'imageUrl': _imageUrl});
      model.store(review);
      Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRando.id);
    }else{
      print('Erreur');
      print(res.body);
    }
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera
    );
    
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery
    );

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context){
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return SafeArea(
        child: Container(
            child: Wrap(
                children: [
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Depuis la galerie'),
                      onTap: (){
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }
                  ),
                  ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Depuis l\'appareil photo'),
                      onTap: (){
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      }
                  )
                ]
            )
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<ReviewViewModel>.reactive(
        builder: (context, model, child) =>
            Scaffold(
                body: SingleChildScrollView(
                    child:Container(
                      height:  MediaQuery.of(context).size.height,
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
                                                  RatingBar.builder(
                                                    initialRating: rating,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding: EdgeInsets.symmetric(
                                                        horizontal: 2.0),
                                                    itemBuilder: (context, _) => Icon(
                                                      Icons.brightness_1_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    onRatingUpdate: (currentRating) {
                                                       setState(() {
                                                         rating = currentRating;
                                                       });
                                                    },
                                                    itemSize: 20.0,
                                                  ),
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


                                      OutlinedButton(
                                        onPressed: () {_showPicker(context);},
                                        child: Text('Envoyer une image'),
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
                                          if (_imageUrl!=null) {
                                            review.addAll({
                                              'avis': reviewController.text,
                                              'note': rating,
                                              'imageUrl': _imageUrl
                                            });
                                            model.store(review);
                                            Navigator.pushNamed(
                                                context, detailRando,
                                                arguments: currentConfig
                                                    .currentRando.id);
                                          }
                                          else{
                                            _sendImage(model);
                                          }
                                         //
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
                )
            ),
        viewModelBuilder: () => ReviewViewModel(),
        onModelReady: (model) => {
        }
    );
  }
}