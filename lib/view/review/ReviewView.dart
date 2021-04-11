import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/review/ReviewViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/button_cloud.dart';
import 'package:stacked/stacked.dart';

List<Rando> futureRandos;

getRandos() async {
  futureRandos = await Rando.fetchRandos();
}

class ReviewView extends StatefulWidget {
  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReviewViewModel>.reactive(
        builder: (context, model, child) => Scaffold(
                body: Container(
              decoration: BoxDecoration(
                  gradient: RadialGradient(
                      colors: [
                    Color(0xFF2AB7F6),
                    Color(0xFF5EC8F8),
                    Color(0xFFCAE67B)
                  ],
                      stops: [
                    0,
                    0.2,
                    1
                  ],
                      center: Alignment(1, 2),
                      focal: Alignment.bottomRight,
                      focalRadius: 2)),
              child: Center(
                  child: Column(children: [
                Container(
                    margin: EdgeInsets.only(
                        left: 40, right: 40, top: 60, bottom: 40),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(model.header,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(model.heading,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w300)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: ButtonCloud(),
                      ),
                      OutlinedButton(
                        child: Text('Continuer'),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.lightBlue,
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () {
                          print('Pressed');
                        },
                      ),

                      OutlineButton(
                        onPressed: () async {
                          await getRandos();
                          Navigator.pushNamed(context, core, arguments: {
                            "selectedIndex": 0,
                            "randosCollection": futureRandos
                          });
                        },
                        child: Text('Passer cette étape',
                            style: TextStyle(color: Colors.white)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      )
                    ])),
              ])),
            )),
        viewModelBuilder: () => ReviewViewModel());
  }
}
