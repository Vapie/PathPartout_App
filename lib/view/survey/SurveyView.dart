import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyViewModel.dart';
import 'package:mvvm_flutter_app/widget/podometer/Podometre.dart';
import 'package:stacked/stacked.dart';

int _quizz = null;
Map<String, String> answers = {};
int status = 0;
Future futureRandos;

getRandos() async {
  futureRandos = await Rando;
}


class SurveyView extends StatefulWidget {
  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SurveyViewModel>.reactive(
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
                                        model.question,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35
                                        )
                                    ),
                                    SizedBox(height: 25),
                                    RadioListTile(
                                        value: 1,
                                        groupValue: _quizz,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _quizz = newValue;
                                            answers.addAll({model.question: model.answer1});
                                            print(answers);
                                          });
                                        },
                                        title: Text(
                                            model.answer1,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20
                                            )
                                        )
                                    ),
                                    RadioListTile(
                                        value: 2,
                                        groupValue: _quizz,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _quizz = newValue;
                                            answers.addAll({model.question: model.answer2});
                                            print(answers);
                                          });
                                        },
                                        title: Text(
                                            model.answer2,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20
                                            )
                                        )
                                    ),
                                    RadioListTile(
                                        value: 3,
                                        groupValue: _quizz,
                                        onChanged: (newValue) {
                                          setState(() {
                                            _quizz = newValue;
                                            answers.addAll({model.question: model.answer3});
                                            print(answers);
                                          });
                                        },
                                        title: Text(
                                            model.answer3,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20
                                            )
                                        )
                                    ),
                                    SizedBox(height: 50),

                                    if(_quizz != null) OutlineButton(
                                      onPressed: () {
                                        model.changeQuestions();
                                        // if status 4 appelle storeAnswers() avec un navigation a la fin
                                        setState(() {
                                          _quizz = null;
                                          status++;
                                          if(status >= 3) {
                                            model.storeAnswers(answers);
                                            getRandos();
                                            Navigator.pushNamed(context, mapRando,
                                                arguments: {
                                                  "selectedIndex": 1,
                                                  "randosCollection": futureRandos
                                                });
                                          }
                                        });
                                      },
                                      child: Text('Continuer',
                                          style: TextStyle(
                                              color: Colors.white)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),

                                      /*OutlineButton(
                                      onPressed: () async {
                                        final futureRandos = await Rando
                                            .fetchRandos();
                                        Navigator.pushNamed(context, core,
                                            arguments: {
                                              "selectedIndex": 1,
                                              "randosCollection": futureRandos
                                            });
                                      },
                                      child: Text('Passer cette étape',
                                          style: TextStyle(
                                              color: Colors.white)),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              8.0)),
                                      borderSide: BorderSide(
                                        color: Colors.white,
                                      ),
                                    )*/
                                  ]
                              )
                          ),
                        ]
                    )
                ),
              )
          ),
      viewModelBuilder: () => SurveyViewModel(),
      onModelReady: (model) => {
        model.debug(),
        model.init()
      }
    );
  }
}

