import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:stacked/stacked.dart';
import 'ProfileViewModel.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5, left: 12),
            child: Center(
              child: Column(children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 40),
                child: Column(children: [
              Container(
                margin: EdgeInsets.only(right: 180),
                child: Text("Mon Profil",
                style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: Colors.blue)),
                ),
              SizedBox(height: 20),

                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Color(0xFFF29696),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                      child: Text("model.role",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(14),
                              bottomLeft: Radius.circular(14)),
                          color: Color(0xFFF29696)),
                      height: 6,
                      width: 72,
                    ),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("https://pbs.twimg.com/profile_images/1276124867767738374/JaYqnkUW_400x400.jpg"),
                    )
                  ]),

                  Container(
                    margin: EdgeInsets.only(right: 180, top: 40),
                    child: Text("Infos Publiques",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                            color: Colors.blue)),
                  ),

                  Row(
                    children: [
                      FlatButton(
                        child: Row(
                          children: [
                            Text("Mon nom"),
                            Icon(Icons.accessibility),
                          ],
                        ),
                      ),
                        // icon: Icon(Icons.volume_up),
                        // tooltip: 'Increase volume by 10',
                        // color: Colors.green,

                      new DropdownButton<String>(
                        hint: Text('Mon age'),
                        items: <String>['32 ans', 'XX ans', 'C', 'D'].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      )
                    ],

                  ),
                  Container(
                    margin: EdgeInsets.only(right: 180, top: 40),
                    child: Text("Mes statistiques",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: Colors.blue)),
                  ),
              ],
            ))
    ]))),

          appBar: myAppBar(),
          endDrawer:AppDrawer()
      ),
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
