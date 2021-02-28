import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyViewModel.dart';
import 'package:stacked/stacked.dart';

int quizz;

class SurveyView extends StatelessWidget {
  const SurveyView({Key key}) : super(key: key);

  void _handleRadioValueChange(int val){
    quizz = val;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SurveyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
         floatingActionButton: FloatingActionButton(onPressed: () async {
           final futureRandos = await Rando.fetchRandos();
           Navigator.pushNamed(context, core, arguments: {"selectedIndex": 1,"randosCollection" : futureRandos });
        },),
          body: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Color(0xFF2AB7F6), Color(0xFF5EC8F8), Color(0xFFCAE67B)],
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
                          margin: EdgeInsets.only(left: 40, right: 40, top: 60, bottom: 40),
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
                                SizedBox(height: 50),
                                Text(
                                  model.heading,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w300
                                  )
                                ),
                                SizedBox(height: 50),
                                Text(
                                  model.surveyStart,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35
                                  )
                                ),
                                SizedBox(height: 25),
                                RadioListTile(
                                  value: 1,
                                  groupValue: quizz,
                                  onChanged: (val) => _handleRadioValueChange(val),
                                  title: Text(
                                    model.survey1,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                    )
                                  )
                                ),
                                RadioListTile(
                                    value: 2,
                                    groupValue: quizz,
                                    onChanged: null,
                                    title: Text(
                                        model.survey2,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        )
                                    )
                                ),
                                RadioListTile(
                                    value: 3,
                                    groupValue: quizz,
                                    onChanged: null,
                                    title: Text(
                                        model.survey3,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20
                                        )
                                    )
                                ),
                                SizedBox(height: 50),
                                OutlineButton(
                                  onPressed: null,
                                  child: Text('Passer cette étape', style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                )
                              ]
                          )
                      ),
                    ]
                )
            ),
          )
      ),
      viewModelBuilder: () => SurveyViewModel(),
      onModelReady: (model) => model.newString(),
    );
  }
}

