import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:stacked/stacked.dart';
import '../../widget/rando/rando-detail.dart';
import 'RandoViewModel.dart';

class RandoView extends StatelessWidget {
  int randoId;

  RandoView(int randoId, {Key key}) : super(key: key) {
    this.randoId = randoId;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, survey);
          },
        ),
        body: Center(child: RandoDetail(randoId: this.randoId)),
        appBar: myAppBar(),
        endDrawer: AppDrawer()
      ),
      viewModelBuilder: () => RandoViewModel(),
      onModelReady: (model) => model.newString(),
    );
  }
}
