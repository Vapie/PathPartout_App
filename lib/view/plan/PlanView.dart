import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/view/plan/PlanViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/map/map.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-detail.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';

import 'package:stacked/stacked.dart';

class PlanView extends StatelessWidget {
  const PlanView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanViewModel>.reactive(
      builder: (context, model, child) => Scaffold(

        body: Center(child: MyMap(2)),
        appBar: myAppBar(),
        endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => PlanViewModel(),
      //onModelReady: (model) => model.loadrandos(),
    );
  }
}



