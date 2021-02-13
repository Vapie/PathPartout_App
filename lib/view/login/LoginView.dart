import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/naviguation/routes.dart';
import 'package:mvvm_flutter_app/view/login/LoginViewModel.dart';

import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
         floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, survey, arguments: 'Data from home');
        },),
          body: Center(child: Text("Login")),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (model) => model.newstring(),
    );
  }
}

