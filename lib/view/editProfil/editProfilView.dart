import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_flutter_app/classes/avatar.dart';
import 'package:mvvm_flutter_app/classes/user.dart';
import 'package:mvvm_flutter_app/main.dart';
import 'package:mvvm_flutter_app/classes/titre.dart';
import 'package:easy_gradient_text/easy_gradient_text.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:mvvm_flutter_app/navigation/routes.dart';

/// Assets to test network access.

class editProfilView extends StatefulWidget {
  const editProfilView({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<editProfilView> {

  final List<Widget> _painters = <Widget>[];
  double _dimension;

  @override
  void initState() {
    super.initState();
    _dimension = 300;
  }

  @override
  Widget build(BuildContext context) {
    if (_dimension > MediaQuery.of(context).size.width - 10.0) {
      _dimension = MediaQuery.of(context).size.width - 10.0;
    }
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      body: Column(children: <Widget>[
        Expanded(
          child: (
                SvgPicture.network(
                  currentConfig.currentUser.avatar.getImageUrl(),
                  placeholderBuilder: (BuildContext context) => Container(
                      height: 300,
                      width: 300,
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                )
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Container (
                        width: 120,
                        child: GradientText(
                          text: 'Titre',
                          colors: <Color>[
                            Color(0xFF2AB7F6),
                            Color(0xFF5EC8F8),
                            Color(0xFFCAE67B)
                          ],
                          gradientDirection: GradientDirection.rtl,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 50),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.badge.name,
                                    items: getListName(name),
                                    hint: new Text("select name"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.badge.name = value;
                                      setState(() {
                                      });
                                    }),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            width: 150,
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                  value: currentConfig.currentUser.badge.adj,
                                  items: getListAdjective(adjective),
                                  hint: new Text("select adjective"),
                                  onChanged: (value) {
                                    currentConfig.currentUser.badge.adj = value;
                                    setState(() {
                                    });
                                  },),
                              ],
                            ),),
                        ],
                      )
                    ],
                  )
              ),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Container (
                        width: 120,
                        child: GradientText(
                          text: 'Avatar',
                          colors: <Color>[
                            Color(0xFF2AB7F6),
                            Color(0xFF5EC8F8),
                            Color(0xFFCAE67B)
                          ],
                          gradientDirection: GradientDirection.rtl,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                  value: currentConfig.currentUser.avatar.top.libApi,
                                  items: getListItem(topType),
                                  hint: new Text("select hat"),
                                    onChanged: (value) {
                                    currentConfig.currentUser.avatar.top = SubAvatarItem.getSubAvatarItemFrom(value,topType[0]);
                                    setState(() {
                                  });
                                })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.accessories.libApi,
                                    items: getListItem(accessoriesType),
                                    hint: new Text("select accessories"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.accessories = SubAvatarItem.getSubAvatarItemFrom(value,accessoriesType[0]);
                                      setState(() {
                                      });
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.facialHair.libApi,
                                    items: getListItem(facialHairType),
                                    hint: new Text("select facial hair"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.facialHair = SubAvatarItem.getSubAvatarItemFrom(value,facialHairType[0]);
                                    setState(() {
                                  });
                                })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 40),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.hairColo.libApi,
                                    items: getListItem(hairColor),
                                    hint: new Text("select hair color"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.hairColo = SubAvatarItem.getSubAvatarItemFrom(value,hairColor[0]);
                                      setState(() {
                                      });
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.clothe.libApi,
                                    items: getListItem(clotheType),
                                    hint: new Text("select clothes"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.clothe = SubAvatarItem.getSubAvatarItemFrom(value,clotheType[0]);
                                    setState(() {
                                  });
                                })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 60),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.clotheColo.libApi,
                                    items: getListItem(clotheColor),
                                    hint: new Text("clothes color"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.clotheColo = SubAvatarItem.getSubAvatarItemFrom(value,clotheColor[0]);
                                      setState(() {
                                      });
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.eye.libApi,
                                    items: getListItem(eyeType),
                                    hint: new Text("select eyes"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.eye = SubAvatarItem.getSubAvatarItemFrom(value,eyeType[0]);
                                    setState(() {
                                  });
                                })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 75),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.eyebrow.libApi,
                                    items: getListItem(eyebrowType),
                                    hint: new Text("select eyebrow"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.eyebrow = SubAvatarItem.getSubAvatarItemFrom(value,eyebrowType[0]);
                                      setState(() {
                                      });
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.mouth.libApi,
                                    items: getListItem(mouthType),
                                    hint: new Text("select mouth"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.mouth = SubAvatarItem.getSubAvatarItemFrom(value,mouthType[0]);
                                    setState(() {
                                  });
                                })
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 80),
                            child: Column(
                              children : <Widget>[
                                new DropdownButton(
                                    value: currentConfig.currentUser.avatar.skinColo.libApi,
                                    items: getListItem(skinColor),
                                    hint: new Text("select skin"),
                                    onChanged: (value) {
                                      currentConfig.currentUser.avatar.skinColo = SubAvatarItem.getSubAvatarItemFrom(value,skinColor[0]);
                                      setState(() {
                                      });
                                    })
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
        FlatButton(onPressed: (){
          User.modifyUserAvantarAndBadge(currentConfig.currentUser.badge.name,currentConfig.currentUser.badge.adj);
          Navigator.pushNamed(context, core, arguments: { "selectedIndex": 2, "randosCollection": currentConfig.getCurrentRandoList()});
        }, child: Text("Save"))
      ]),
    );
  }

  List<DropdownMenuItem<String>> getListItem(List<SubAvatarItem> itemList) {
    List<DropdownMenuItem<String>> allItemForDropdown = [];
    for (SubAvatarItem item in itemList){
      if (item.isUnlock) {
        allItemForDropdown.add(new DropdownMenuItem(
          child: new Text(item.libUI),
          value: item.libApi,
        ));
      }
    }
    return allItemForDropdown;
  }

  getListName(List<NameTitle> nameList) {
    List<DropdownMenuItem<String>> allNameForTitre = [];
    print(nameList);
    for (NameTitle name in nameList) {
      print(name.isUnlock);
      if (name.isUnlock)
        allNameForTitre.add(new DropdownMenuItem(
          child: new Text(name.libName),
          value: name.libName,
        ));

    }
    return allNameForTitre;
  }

  getListAdjective(List<AdjectiveTitle> adjectiveList){
    List<DropdownMenuItem<String>> allAdjectiveList = [];
    for (AdjectiveTitle adjective in adjectiveList) {
      if (adjective.isUnlock) {
        allAdjectiveList.add(new DropdownMenuItem(
          child: new Text(adjective.libAdjective),
          value: adjective.libAdjective,
        ));
      }
    }
    return allAdjectiveList;
  }
}