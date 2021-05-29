import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_flutter_app/classes/avatar.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/classes/titre.dart';

/// Assets to test network access.


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
  String selectedName = "Marcheur";
  String selectedAdjective = "ordinaire";

  @override
  void initState() {
    super.initState();
    _dimension = 203.0;




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

        Row(children: [
          new DropdownButton(
            value: selectedName,
            items: getListName(name),
            hint: new Text("select name"),
          onChanged: (value) {
    selectedName = value;
      setState(() {
      });
      }),
          new DropdownButton(
              value: selectedAdjective,
              items: getListAdjective(adjective),
              hint: new Text("select adjective"),
            onChanged: (value) {
                selectedAdjective = value;
                setState(() {
                });
            },
          )
      ],),
        Expanded(
          child: GridView.extent(
            shrinkWrap: true,
            maxCrossAxisExtent: _dimension,
            padding: const EdgeInsets.all(4.0),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            children: [
              SvgPicture.network(
                currentConfig.currentAvatar.getImageUrl(),
                placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30.0),
                    child: const CircularProgressIndicator()),
              )
            ]
          ),
        ),
        new DropdownButton(
            value: currentConfig.currentAvatar.top.libApi,
            items: getListItem(topType),
            hint: new Text("select hat"),

            onChanged: (value) {
              currentConfig.currentAvatar.top = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.accessories.libApi,
            items: getListItem(accessoriesType),
            hint: new Text("select accessories"),
            onChanged: (value) {
              currentConfig.currentAvatar.accessories = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.facialHair.libApi,
            items: getListItem(facialHairType),
            hint: new Text("select facial hair"),
            onChanged: (value) {
              currentConfig.currentAvatar.facialHair = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.hairColo.libApi,
            items: getListItem(hairColor),
            hint: new Text("select hat"),
            onChanged: (value) {
              currentConfig.currentAvatar.hairColo = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.clothe.libApi,
            items: getListItem(clotheType),
            hint: new Text("select clothes"),
            onChanged: (value) {
              currentConfig.currentAvatar.clothe = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.clotheColo.libApi,
            items: getListItem(clotheColor),
            hint: new Text("clothes color"),
            onChanged: (value) {
              currentConfig.currentAvatar.clotheColo = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.eye.libApi,
            items: getListItem(eyeType),
            hint: new Text("select eyes"),
            onChanged: (value) {
              currentConfig.currentAvatar.eye = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.eyebrow.libApi,
            items: getListItem(eyebrowType),
            hint: new Text("select eyebrow"),
            onChanged: (value) {
              currentConfig.currentAvatar.eyebrow = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.mouth.libApi,
            items: getListItem(mouthType),
            hint: new Text("select mouth"),
            onChanged: (value) {
              currentConfig.currentAvatar.mouth = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),new DropdownButton(
            value: currentConfig.currentAvatar.skinColo.libApi,
            items: getListItem(skinColor),
            hint: new Text("select skin"),
            onChanged: (value) {
              currentConfig.currentAvatar.skinColo = SubAvatarItem.getSubAvatarItemFrom(value);
              setState(() {
              });
            }),
      ]),
    );
  }

  List<DropdownMenuItem<String>> getListItem(List<SubAvatarItem> itemList) {
    List<DropdownMenuItem<String>> allItemForDropdown = [];
      for (SubAvatarItem item in itemList){
        allItemForDropdown.add(new DropdownMenuItem(
          child: new Text(item.libUI),
          value: item.libApi,
        ));
      }
    return allItemForDropdown;
  }


  getAvatarItemFromValue(List<SubAvatarItem> itemList) {
    List<DropdownMenuItem<String>> allItemForDropdown = [];
    for (SubAvatarItem item in itemList){
      allItemForDropdown.add(new DropdownMenuItem(
        child: new Text(item.libUI),
        value: item.libApi,
      ));
    }
    return allItemForDropdown;
  }



  getListName(List<NameTitle> nameList){
    List<DropdownMenuItem<String>> allNameForTitre = [];
      for (NameTitle name in nameList){
        allNameForTitre.add(new DropdownMenuItem(
          child: new Text(name.libName),
          value: name.libName,
        ));
      }
      return allNameForTitre;
  }

  getListAdjective(List<AdjectiveTitle> adjectiveList){
    List<DropdownMenuItem<String>> allAdjectiveList = [];
      for (AdjectiveTitle adjective in adjectiveList){
        allAdjectiveList.add(new DropdownMenuItem(
          child: new Text(adjective.libAdjective),
          value: adjective.libAdjective,
        ));
      }
      return allAdjectiveList;
  }
}
