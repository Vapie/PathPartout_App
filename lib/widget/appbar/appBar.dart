import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';


class myAppBar extends StatelessWidget implements PreferredSizeWidget {

  /// you can add more fields that meet your needs

  const myAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
       leading: Image.asset('assets/picture/logo.png'),
       actions:[ IconButton(
         icon: new Icon(Icons.dehaze_outlined,
          color:Colors.black87),
         onPressed: () =>  Scaffold.of(context).openEndDrawer(),
       )],
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(60);

}
