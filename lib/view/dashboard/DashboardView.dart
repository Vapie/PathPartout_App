import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/dashboard-tile/dashboard-tile.dart';

const double gutter = 10.0;

class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      endDrawer: AppDrawer(),
      body: Center(
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, achievements);
                      },
                      child:Padding(
                        padding: const EdgeInsets.all(gutter),
                        child: DashboardTile("achievement", 0.4, "Achievements"),
                      )),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: gutter),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: gutter),
                          child: Row(children: [
                            Expanded(
                                child: DashboardTile("rando", 0.195,
                                    "Rando conseillée pour vous"))
                          ]),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: DashboardTile(
                                    "qrcode", 0.195, "Scan QR Code"))
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),

            // Performances
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: gutter, right: gutter, bottom: gutter),
                      child: DashboardTile("performances", 0.195, "Mes performances")
                  ),
                ),
              ],
            ),

            // Profil
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: gutter, right: gutter, bottom: gutter),
                      child: DashboardTile("profil", 0.21, "Mon profil")
                  ),

                ),
              ],
            ),

            // Publicité
            Row(
              children: [
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: gutter, right: gutter, bottom: gutter),
                      child: DashboardTile("pub", 0.195, "Publicité")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
