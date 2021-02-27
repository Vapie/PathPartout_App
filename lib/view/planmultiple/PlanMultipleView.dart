import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/plan/PlanViewModel.dart';
import 'package:mvvm_flutter_app/view/planmultiple/PlanMultipleViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/map/map-multiple-points.dart';
import 'package:stacked/stacked.dart';

class PlanMultipleView extends StatelessWidget {
  const PlanMultipleView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanMultipleViewModel>.reactive(
      builder: (context, model, child) => Scaffold(

        body: Center(child: MyMapMultiMarkers()),
        appBar: myAppBar(),
        endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => PlanMultipleViewModel(),
      //onModelReady: (model) => model.loadRandos(),
    );
  }
}



