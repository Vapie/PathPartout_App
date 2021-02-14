import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/view/core/CoreViewModel.dart';
import 'package:mvvm_flutter_app/view/core/navbar/navBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';

import 'package:stacked/stacked.dart';

import '../../widget/appbar/appBar.dart';

class CoreView extends StatelessWidget {
  const CoreView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoreViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          bottomNavigationBar: MyNavigationBar() ,

      ),
      viewModelBuilder: () => CoreViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

