import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/core/CoreViewModel.dart';
import 'package:mvvm_flutter_app/view/core/navbar/navBar.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';

import 'package:stacked/stacked.dart';

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

