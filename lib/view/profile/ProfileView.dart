import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'ProfileViewModel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Center(child: Text("Profile")),
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
