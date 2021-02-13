import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/view/plan/PlanViewModel.dart';

import 'package:stacked/stacked.dart';

class PlanView extends StatelessWidget {
  const PlanView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanViewModel>.reactive(
      builder: (context, model, child) => Scaffold(

          body: Center(child: Text("Plan")),
      ),
      viewModelBuilder: () => PlanViewModel(),

    );
  }
}

