
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/view/share/ShareViewModel.dart';
import 'package:mvvm_flutter_app/widget/media/sorties-wrapper.dart';
import 'package:stacked/stacked.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';

bool _visible = true;
int quizz;

class ProfileView extends StatefulWidget {
  // const ShareView({Key key}) : super(key: key);
  ProfileView() : super();
  @override
  State<StatefulWidget> createState() => ProfileViewState();
}

class ProfileViewState extends State<ProfileView> {
  dynamic varPoubelle;
  List<charts.Series> seriesList;


  Future<dynamic> getSortiesData() async {

    double nbKm = 0;
    double min = 0;
    double sec = 0;
    double heure = 0;
    int NbPas = 0;
    int tempsTot;
    List<Sortie> sorties = await Sortie.getUserSorties();
    for(Sortie sortie in sorties) {
      if(sortie.randonnee.distance != null){
        nbKm = nbKm+ sortie.randonnee.distance;
      }

      if(sortie.performances != null){
        // nbKm = nbKm+ sortie.randonnee.distance;
        List<String> SplittedHeure = sortie.performances[1].split(":");
        heure += int.parse(SplittedHeure[0]) + int.parse(SplittedHeure[1])/60;
        min += int.parse(SplittedHeure[1]) + int.parse(SplittedHeure[2])/60;
        NbPas += int.parse(sortie.performances[0]);

      }


    }

    //TODO dynamic
    List<Dist> tabpas = [Dist("Nov",820),Dist("Dec",450),Dist("Jan",850),Dist("Fev",930),Dist("Mars",1200),Dist("Avr",NbPas)];
    varPoubelle = {"nbKm":nbKm.round(),"tempsTot":heure.round().toString() +" h "+ min.round().toString() + "min","LastPost":tabpas};
    return varPoubelle;
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(context) {
    return FutureBuilder<dynamic>(
        future: getSortiesData(),
    builder: (context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
    return  ListView(
           children:[ Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
              ),
              child: Center(
                  child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 40, right: 40, top: 60, bottom: 10),
                            child: Column(
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(right: 100),
                                    child: Row(
                                      children: [

                                        Container(
                                          margin: EdgeInsets.only(left: 25),
                                          width: 200,
                                          child: Text(
                                              "Mon profil",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 28,
                                                  color: Colors.black87
                                              )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12.0),
                                            color: Color(0xFFF29696),
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                          child: Text(
                                              "Curieuse aguerrie",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(14), bottomLeft: Radius.circular(14)),
                                              color: Color(0xFFF29696)
                                          ),
                                          height: 6,
                                          width: 52,
                                        ),
                                        CircleAvatar(
                                          radius: 40,
                                          backgroundImage: AssetImage('assets/picture/portrait.jpg'),
                                        )
                                      ]
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Infos publiques",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold ,
                                          fontSize: 25,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
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
                                        hint: Text('Mon age'
                                        ),
                                        items: <String>['32 ans', '33ans', '34 ans', '35 ans'].map((String value) {
                                          return new DropdownMenuItem<String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (_) {},
                                      )
                                    ],

                                  ),

                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Mes statistiques",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold ,
                                          fontSize: 25,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // width: 135,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Distance parcourue',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: GradientText(
                                                    text: varPoubelle["nbKm"].toString() + ' km',
                                                    colors: <Color>[
                                                      Color(0xFF2AB7F6),
                                                      Color(0xFF5EC8F8),
                                                      Color(0xFFCAE67B)
                                                    ],
                                                    gradientDirection: GradientDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 25
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          // width: 135,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                color: Colors.white
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: 120,
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    "Temps passé en montagne",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.bottomRight,
                                                  margin: EdgeInsets.only(top: 10),
                                                  child: GradientText(
                                                    text: varPoubelle["tempsTot"].toString(),
                                                    colors: <Color>[
                                                      Color(0xFF2AB7F6),
                                                      Color(0xFF5EC8F8),
                                                      Color(0xFFCAE67B)
                                                    ],
                                                    gradientDirection: GradientDirection.rtl,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 25
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        color: Colors.white
                                    ),
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                        children: [
                                          Text(
                                            'Kilomètres mensuels',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18
                                            ),
                                          ),
                                          Container(
                                            height: 175,
                                            child: charts.BarChart(
                                              [
                                                charts.Series<Dist, String>(
                                                  id: 'kmMensu',
                                                  domainFn: (Dist dist, _) => dist.month,
                                                  measureFn: (Dist dist, _) => dist.dist,
                                                  colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFF29696)),
                                                  data: [
                                                    for(Dist dist in varPoubelle["LastPost"])
                                                      dist
                                                  ],
                                                )
                                              ],
                                              animate: true,
                                              vertical: true,
                                              domainAxis: charts.OrdinalAxisSpec(
                                                  renderSpec: charts.SmallTickRendererSpec()
                                              ),
                                              primaryMeasureAxis: charts.NumericAxisSpec(
                                                  renderSpec: charts.SmallTickRendererSpec(),
                                                  tickProviderSpec: charts.BasicNumericTickProviderSpec(
                                                      dataIsInWholeNumbers: true, desiredTickCount: 5)),
                                              defaultRenderer: new charts.BarRendererConfig(
                                                cornerStrategy: const charts.ConstCornerStrategy(8),
                                              ),
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                  SizedBox(height: 20),

                                  Row(
                                    children: [
                                      Text(
                                        "Mes sorties",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold ,
                                          fontSize: 25,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),                                ]
                            )
                        ),
                      ]
                  )
              ),

            )
           ,
             SortiesWrapper()]
    );
    } else {
      return CircularProgressIndicator();
    }
    });
  }
}

class Dist {
  final String month;
  final int dist;

  Dist(this.month, this.dist);
}

/*
class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec()
      ),
      primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(),
          tickProviderSpec: charts.BasicNumericTickProviderSpec(
              dataIsInWholeNumbers: true, desiredTickCount: 5)),
      defaultRenderer: new charts.BarRendererConfig(
        cornerStrategy: const charts.ConstCornerStrategy(8),
      ),
    );
  }

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
                  Row(
                    children: [
                      Text(
                        "Mes statistiques",
                        style: TextStyle(
                          fontWeight: FontWeight.bold ,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          // width: 135,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Distance parcourue",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(top: 10),
                                  child: GradientText(
                                    text: '15 km',
                                    colors: <Color>[
                                      Color(0xFF2AB7F6),
                                      Color(0xFF5EC8F8),
                                      Color(0xFFCAE67B)
                                    ],
                                    gradientDirection: GradientDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          // width: 135,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Colors.white
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 120,
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Temps passé en montagne",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  margin: EdgeInsets.only(top: 10),
                                  child: GradientText(
                                    text: '5 h 12',
                                    colors: <Color>[
                                      Color(0xFF2AB7F6),
                                      Color(0xFF5EC8F8),
                                      Color(0xFFCAE67B)
                                    ],
                                    gradientDirection: GradientDirection.rtl,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
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
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white
                    ),
                    alignment: Alignment.topLeft,
                    child: Column(
                        children: [
                          Text(
                            'Kilomètres mensuels',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                            ),
                          ),
                          Container(
                            height: 175,
                            child: barChart(),
                          )
                        ]
                    ),
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
*/