import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';


import 'package:stacked/stacked.dart';

import '../../widget/rando/rando-detail.dart';
import 'RandoViewModel.dart';

class RandoView extends StatelessWidget {
  int RandoId;

  RandoView(int RandoId, {Key key}) : super(key: key){
    this.RandoId = RandoId;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandoViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
         floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, survey);
        },),
          body: Center(child: RandoDetail(RandoId: this.RandoId)),
      ),
      viewModelBuilder: () => RandoViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

