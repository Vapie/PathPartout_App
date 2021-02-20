import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyViewModel.dart';
import 'package:stacked/stacked.dart';

class SurveyView extends StatelessWidget {
  const SurveyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SurveyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
         floatingActionButton: FloatingActionButton(onPressed: () async {
           final futureRandos = await Rando.fetchRandos();
           Navigator.pushNamed(context, core, arguments: {"selectedIndex": 1,"randosCollection" : futureRandos });
        },),
          body: Center(child: Text("Survey")),

      ),
      viewModelBuilder: () => SurveyViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

