import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/MainConfig.dart';
import 'package:mvvm_flutter_app/notification/rando-notif.dart';
import 'package:mvvm_flutter_app/view/plan/PlanViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/map/map-multiple-points.dart';
import 'package:mvvm_flutter_app/widget/map/map.dart';
import 'package:stacked/stacked.dart';

class PlanView extends StatelessWidget {
  int randoId;

  MainConfig currentConfig;

  PlanView({int randoId, MainConfig currentConfig, Key key}) : super(key: key) {
    this.randoId = randoId;
    this.currentConfig = currentConfig;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PlanViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Center(
              child: Stack(children: [
            MyMap(this.randoId),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.01,
                child: currentConfig.myrandonotif)
          ])),
          appBar: myAppBar(),
          endDrawer: AppDrawer()),
      viewModelBuilder: () => PlanViewModel(),
      //onModelReady: (model) => model.loadRandos(),
    );
  }
}
