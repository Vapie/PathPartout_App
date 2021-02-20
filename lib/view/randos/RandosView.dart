import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/view/randos/RandosViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';
import 'package:stacked/stacked.dart';

class RandosView extends StatelessWidget {
  List<Rando> randos;

  RandosView(List<Rando> randos, {Key key}) : super(key: key){
    this.randos = randos;
    print(randos);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RandosViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Stack (children: [
            Center(child: Text("Randos")),
            RandosList(this.randos)
          ],),
        appBar: myAppBar(),
        endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => RandosViewModel(),
    );
  }
}

