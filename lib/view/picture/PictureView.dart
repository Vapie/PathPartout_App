import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/picture/PictureViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';
import 'package:stacked/stacked.dart';

class PictureView extends StatelessWidget {
  const PictureView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PictureViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Stack (children: [
            Center(child: Text("Picture")),
            RandosList()
          ],),
        appBar: myAppBar(),
        endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => PictureViewModel(),
    );
  }
}

