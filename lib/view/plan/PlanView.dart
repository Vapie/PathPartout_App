import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/plan/PlanViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/map/map-multiple-points.dart';
import 'package:stacked/stacked.dart';

class PlanView extends StatelessWidget {
  const PlanView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanViewModel>.reactive(
      builder: (context, model, child) => Scaffold(

        body: Center(child: MyMapMultiMarkers()),
        appBar: myAppBar(),
        endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => PlanViewModel(),
      //onModelReady: (model) => model.loadRandos(),
    );
  }
}



