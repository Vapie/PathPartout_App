import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/achievement.dart';
import 'package:mvvm_flutter_app/widget/achievements/achievement-row.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/media/achievements-wrapper.dart';
import 'package:stacked/stacked.dart';
import 'package:mvvm_flutter_app/view/achievements/AchievementsViewModel.dart';

class AchievementsView extends StatelessWidget{

  AchievementsView({Key key}) : super(key: key) { }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AchievementsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Scaffold(
            appBar: myAppBar(),
            endDrawer: AppDrawer(),
            body: AchievementsWrapper()
        ),
      ),
      viewModelBuilder: () => AchievementsViewModel(),
    );
  }
}