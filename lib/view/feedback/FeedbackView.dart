import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/view/feedback/FeedbackViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/button_cloud.dart';
import 'package:stacked/stacked.dart';

List<Rando> futureRandos;
int value = 0;
Map<String, String> answers = {};
int status = 0;

getRandos() async {
  futureRandos = await Rando.fetchRandos();
}

class FeedbackView extends StatefulWidget {

  @override
  _FeedbackViewState createState() => _FeedbackViewState();


}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedbackViewModel>.reactive(
      viewModelBuilder: () => FeedbackViewModel(),
      onModelReady: (model) => {model.init()},
      builder: (context, model, child) => Scaffold(
          body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
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
                child: Column(
              children: [
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
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Text(model.heading,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w300)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(model.question,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      ),
                      if (status == 0)
                        Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: ButtonCloud()),
                      if (status > 0)
                        RadioListTile(
                            value: 1,
                            groupValue: value,
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue;
                                answers.addAll({model.question: model.answer1});
                                print(answers);
                              });
                            },
                            title: Text(model.answer1 ?? "Pas de réponse 1",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      if (status > 0)
                        RadioListTile(
                            value: 2,
                            groupValue: value,
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue;
                                answers.addAll({model.question: model.answer2});
                                print(answers);
                              });
                            },
                            title: Text(model.answer2 ?? "Pas de réponse 2",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      if (status > 0)
                        RadioListTile(
                            value: 3,
                            groupValue: value,
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue;
                                answers.addAll({model.question: model.answer3});
                                print(answers);
                              });
                            },
                            title: Text(model.answer3 ?? "Pas de réponse 3",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      SizedBox(height: 50.0),
                      if (value != null)
                        OutlinedButton(
                          child: Text('Continuer'),
                          style: OutlinedButton.styleFrom(
                            primary: Colors.lightBlue,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () async {
                            print(status);
                            model.changeQuestions();
                            // if status 4 appelle storeAnswers() avec un navigation a la fin
                            setState(() {
                              value = null;
                              if (status == 0) {
                                answers.addAll(
                                    {model.question1: selectedTags.toString()});
                                print(selectedTags.toString());
                              }
                              status++;
                            });
                            if (status >= 3) {

                              await model.storeAnswers(answers);
                              print("fini");
                              await getRandos();
                              status=0;
                              value = 0;
                              Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRando.id);
                            }
                          },
                        ),
                      OutlineButton(
                        onPressed: () async {
                          await getRandos();
                          status = 0;
                          value = 0;
                          Navigator.pushNamed(context, detailRando, arguments: currentConfig.currentRando.id);
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
              ],
            ))),
      ])),
    );
  }
}
