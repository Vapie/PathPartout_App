import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';
import 'package:mvvm_flutter_app/view/picture/PictureViewModel.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-container.dart';

import 'package:stacked/stacked.dart';

class PictureView extends StatelessWidget {
  const PictureView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PictureViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Stack (children: [
            Center(child: Text("Picture")),
            RandoContainer(2)
          ],),

      ),
      viewModelBuilder: () => PictureViewModel(),
    );
  }
}

