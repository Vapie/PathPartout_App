import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_flutter_app/classes/avatar.dart';

/// Assets to test network access.
const List<String> uriNames = <String>[
  'https://avataaars.io/?avatarStyle=Circle',
  'https://avataaars.io/?accessoriesType=Prescription01&avatarStyle=Circle&clotheType=Hoodie&eyeType=EyeRoll&eyebrowType=UnibrowNatural&facialHairType=BeardLight&hairColor=Black&mouthType=Eating&skinColor=Yellow&topType=LongHairShavedSides',
];


// class MyApp extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Avatar Demo',
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: const _MyHomePage(title: 'Flutter Avatar SVG Demo'),
  //   );
  // }
// }

class editProfilView extends StatefulWidget {
  const editProfilView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<editProfilView> {
  final List<Widget> _painters = <Widget>[];
  double _dimension;
  String selectedHat;
  String selectedAccessories;
  String selectedFacialHairType;
  String selectedHairColor;
  String selectedClothe;
  String selectedClotheColor;
  String selectedEye;
  String selectedEyebrowType;
  String selectedMouthType;
  String selectedSkinColor;

  @override
  void initState() {
    super.initState();
    _dimension = 203.0;

    for (String uriName in uriNames) {
      _painters.add(
        SvgPicture.network(
          uriName,
          placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator()),
        ),
      );
    }
//     // Shows an example of an SVG image that will fetch a raster image from a URL.
//     _painters.add(SvgPicture.string('''<svg viewBox="0 0 200 200"
//   xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
//   <image xlink:href="https://mdn.mozillademos.org/files/6457/mdn_logo_only_color.png" height="200" width="200"/>
// </svg>'''));
//     _painters.add(AvdPicture.asset('assets/android_vd/battery_charging.xml'));
  }

  @override
  Widget build(BuildContext context) {
    if (_dimension > MediaQuery.of(context).size.width - 10.0) {
      _dimension = MediaQuery.of(context).size.width - 10.0;
    }
    return Scaffold(
      body: Column(children: <Widget>[
        Slider(
            min: 5.0,
            max: MediaQuery.of(context).size.width - 10.0,
            value: _dimension,
            onChanged: (double val) {
              setState(() => _dimension = val);
            }),
        Expanded(
          child: GridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: _dimension,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: _painters.toList(),
          ),
        ),
        new DropdownButton(
            value: selectedHat,
            items: getListItem(topType),
            hint: new Text("select hat"),
            onChanged: (value) {
              selectedHat = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedAccessories,
            items: getListItem(accessoriesType),
            hint: new Text("select accessories"),
            onChanged: (value) {
              selectedAccessories = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedFacialHairType,
            items: getListItem(facialHairType),
            hint: new Text("select facial hair"),
            onChanged: (value) {
              selectedFacialHairType = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedHairColor,
            items: getListItem(hairColor),
            hint: new Text("select hat"),
            onChanged: (value) {
              selectedHairColor = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedClothe,
            items: getListItem(clotheType),
            hint: new Text("select clothes"),
            onChanged: (value) {
              selectedClothe = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedClotheColor,
            items: getListItem(clotheColor),
            hint: new Text("clothes color"),
            onChanged: (value) {
              selectedClotheColor = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedEye,
            items: getListItem(eyeType),
            hint: new Text("select eyes"),
            onChanged: (value) {
              selectedEye = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedEyebrowType,
            items: getListItem(eyebrowType),
            hint: new Text("select eyebrow"),
            onChanged: (value) {
              selectedEyebrowType = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedMouthType,
            items: getListItem(mouthType),
            hint: new Text("select mouth"),
            onChanged: (value) {
              selectedMouthType = value;
              setState(() {
              });
            }),new DropdownButton(
            value: selectedSkinColor,
            items: getListItem(skinColor),
            hint: new Text("select skin"),
            onChanged: (value) {
              selectedSkinColor = value;
              setState(() {
              });
            }),
      ]),
    );
  }

  getListItem(List<SubAvatarItem> itemList) {
    List<DropdownMenuItem<String>> allItemForDropdown = [];
      for (SubAvatarItem item in itemList){
        allItemForDropdown.add(new DropdownMenuItem(
          child: new Text(item.libUI),
              value: item.libApi,
        ));
      }
    return allItemForDropdown;
  }
}
