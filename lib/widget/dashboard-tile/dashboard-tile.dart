import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardTile extends StatelessWidget {
  var type;
  var height;
  var title;

  DashboardTile(String type, double height, String title, {Key key}) : super(key: key){
    this.type = type;
    this.height = height;
    this.title = title;
  }

  Widget build(BuildContext context) {
    if(type == "achievement") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "rando") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "qrcode") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "performances") {
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "profil"){
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

    if(type == "pub"){
      return Container(
        height: MediaQuery.of(context).size.height * height,
        padding: const EdgeInsets.all(10.0),
        child: Text(title),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
      );
    }

  }
}
