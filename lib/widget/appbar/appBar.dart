import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';

import '../../main.dart';

class myAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs

  const myAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, core, arguments: { "selectedIndex": 1, "randosCollection": currentConfig.getCurrentRandoList()});
        },
        child: FractionallySizedBox(
            heightFactor: 0.7,
            child : Image.asset(
              'assets/picture/logo.png',
              scale: 0.5,
            )),
      ),
      actions: [
         IconButton(
          icon: new Icon(Icons.search, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60);
}