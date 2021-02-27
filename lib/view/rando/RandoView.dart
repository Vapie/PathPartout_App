import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';


import 'package:stacked/stacked.dart';

import '../../widget/rando/rando-detail.dart';
import 'RandoViewModel.dart';

class RandoView extends StatelessWidget {
  int randoId;

  RandoView(int randoId, {Key key}) : super(key: key){
    this.randoId = randoId;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, survey);
        },),
          body: Center(child: RandoDetail(randoId: this.randoId)),
      ),
      viewModelBuilder: () => RandoViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

