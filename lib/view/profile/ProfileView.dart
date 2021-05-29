
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mvvm_flutter_app/classes/sorties.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';
import 'package:mvvm_flutter_app/widget/appbar/appBar.dart';
import 'package:mvvm_flutter_app/widget/appbar/drawer/drawer.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';
import 'package:mvvm_flutter_app/widget/media/sorties-wrapper.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:easy_gradient_text/easy_gradient_text.dart';

import '../../main.dart';

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

    double heure = 0;
    List<int> NbPas = [0,0,0,0,0,0,0,0,0,0,0,0];
    List<Sortie> sorties = await Sortie.getUserSorties();

   int currentmonth =  DateTime.now().month;

    for(Sortie sortie in sorties) {
      if(sortie.randonnee.distance != null){
        nbKm = nbKm+ sortie.randonnee.distance;
      }

      if(sortie.performances != null){

        // nbKm = nbKm+ sortie.randonnee.distance;
        List<String> SplittedHeure = sortie.performances[1].split(":");
        heure += int.parse(SplittedHeure[0]) + int.parse(SplittedHeure[1])/60;
        min += int.parse(SplittedHeure[1]) + int.parse(SplittedHeure[2])/60;

         if (sortie.date.difference(DateTime.now())<Duration(days: 365)){

           NbPas[sortie.date.month-1] += sortie.randonnee.distance.toInt();

         }
      }
    }


    List<String> MonthLabel=["Jan","Fev","Mar","Avr","Mai","Jun","Jul","Aou","Sep","Oct","Nov","Dec"];
    List<Dist> tabpas = [Dist(MonthLabel[(currentmonth-6)%12],NbPas[(currentmonth-6)%12]),
      Dist(MonthLabel[(currentmonth-5)%12],NbPas[(currentmonth-5)%12]),
      Dist(MonthLabel[(currentmonth-4)%12],NbPas[(currentmonth-4)%12]),
      Dist(MonthLabel[(currentmonth-3)%12],NbPas[(currentmonth-3)%12]),
      Dist(MonthLabel[(currentmonth-2)%12],NbPas[(currentmonth-2)%12]),
      Dist(MonthLabel[(currentmonth-1)%12],NbPas[(currentmonth-1)%12])];

    varPoubelle = {"nbKm":nbKm.round(),"tempsTot":(heure + min/60 ).round().toString() +" h "+ (min%60).round().toString() + "min","LastPost":tabpas};
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
    return Scaffold(
        appBar: myAppBar(),
        endDrawer: AppDrawer(),
        body: FutureBuilder<dynamic>(
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
                            margin: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
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

                                       SvgPicture.network(
                                            currentConfig.currentUser.avatar.getImageUrl(),
                                            placeholderBuilder: (BuildContext context) => Container(
                                                padding: const EdgeInsets.all(30.0),
                                                child: const CircularProgressIndicator()),
                                          ),

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
                                  SizedBox(height: 12),
                                  Container(child:GradientButton(child: Text("Modifier le profil",style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold),)),width: 200,alignment: AlignmentDirectional.topStart,),

                                  SizedBox(height: 5),


                                  // Row(
                                  //   children: [
                                  //     FlatButton(
                                  //       child: Row(
                                  //         children: [
                                  //           Text("Mon nom"),
                                  //           Icon(Icons.accessibility),
                                  //         ],
                                  //       ),
                                  //     ),
                                  //     // icon: Icon(Icons.volume_up),
                                  //     // tooltip: 'Increase volume by 10',
                                  //     // color: Colors.green,
                                  //
                                  //     new DropdownButton<String>(
                                  //       hint: Text('Mon age'
                                  //       ),
                                  //       items: <String>['32 ans', '33ans', '34 ans', '35 ans'].map((String value) {
                                  //         return new DropdownMenuItem<String>(
                                  //           value: value,
                                  //           child: new Text(value),
                                  //         );
                                  //       }).toList(),
                                  //       onChanged: (_) {},
                                  //     )
                                  //   ],
                                  //
                                  // ),

                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        "Mes statistiques   ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold ,
                                          fontSize: 25,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.share),
                                        onTap: () => {
                                          Navigator.pushNamed(context, share)
                                        },
                                      ),
                                      GestureDetector(
                                        child: Icon(Icons.edit),
                                        onTap: () => {
                                          Navigator.pushNamed(context, editionProfil)
                                        },
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
                                  ),
                                ]
                            )
                        ),
                      ]
                )
              ),
            ),
             SortiesWrapper()]
    );
    } else {
      return Center(child: CircularProgressIndicator());
    }
    }));
  }
}




class Dist {
  final String month;
  final int dist;

  Dist(this.month, this.dist);
}