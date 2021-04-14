import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/classes/rando.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/view/randos/RandosViewModel.dart';
import 'package:mvvm_flutter_app/view/sorties/SortiesViewModel.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/media/sorties-wrapper.dart';
import 'package:mvvm_flutter_app/widget/rando/addrando-tile.dart';
import 'package:mvvm_flutter_app/widget/rando/rando-tile.dart';
import 'package:mvvm_flutter_app/widget/rando/randos-list.dart';
import 'package:stacked/stacked.dart';

class SortiesView extends StatelessWidget {

  SortiesView({Key key}) : super(key: key) { }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SortiesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          body: Scaffold(
            body: SortiesWrapper()
          ),
      ),
      viewModelBuilder: () => SortiesViewModel(),
    );
  }
}
