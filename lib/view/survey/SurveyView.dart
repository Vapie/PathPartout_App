import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/survey/SurveyViewModel.dart';
import 'package:stacked/stacked.dart';

class SurveyView extends StatelessWidget {
  const SurveyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SurveyViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
         floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, core, arguments: 'Data from home');
        },),
          body: Center(child: Text("Survey")),

      ),
      viewModelBuilder: () => SurveyViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

