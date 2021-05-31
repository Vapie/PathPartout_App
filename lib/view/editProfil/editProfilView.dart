import 'package:flutter/material.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm_flutter_app/classes/achievementUnlocked.dart';
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

  List<String> achievementsUnlocked;
  Future<List<String>> getAchievementsUnlocked() async {
    achievementsUnlocked = await AchievementUnlocked.getUserAchievements();
    return achievementsUnlocked;
  }

  @override
  Widget build(BuildContext context) {
    if (_dimension > MediaQuery.of(context).size.width - 10.0) {
      _dimension = MediaQuery.of(context).size.width - 10.0;
    }
    return FutureBuilder<List<String>>(
        future: getAchievementsUnlocked(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          return Scaffold(
            backgroundColor: Color(0xFFEEEEEE),
            body: Column(children: <Widget>[
              Expanded(
                child: (SvgPicture.network(
                  currentConfig.currentUser.avatar.getImageUrl(),
                  placeholderBuilder: (BuildContext context) => Container(
                      height: 300,
                      width: 300,
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Container(
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
                                    fontSize: 22),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(right: 50),
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser.badge.name,
                                          items: getListName(name,achievementsUnlocked),
                                          hint: new Text("select name"),
                                          onChanged: (value) {
                                            currentConfig
                                                .currentUser.badge.name = value;
                                            setState(() {});
                                          }),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(left: 40),
                                  width: 150,
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                        value:
                                            currentConfig.currentUser.badge.adj,
                                        items: getListAdjective(adjective,achievementsUnlocked),
                                        hint: new Text("select adjective"),
                                        onChanged: (value) {
                                          currentConfig.currentUser.badge.adj =
                                              value;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Container(
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
                                    fontSize: 22),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser.avatar.top.libApi,
                                          items: getListItem(topType,snapshot.data),
                                          hint: new Text("select hat"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar.top = SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, topType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.accessories.libApi,
                                          items: getListItem(accessoriesType,snapshot.data),
                                          hint: new Text("select accessories"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .accessories =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(value,
                                                        accessoriesType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.facialHair.libApi,
                                          items: getListItem(facialHairType,snapshot.data),
                                          hint: new Text("select facial hair"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .facialHair =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(value,
                                                        facialHairType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.hairColo.libApi,
                                          items: getListItem(hairColor,snapshot.data),
                                          hint: new Text("select hair color"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .hairColo =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, hairColor[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig
                                              .currentUser.avatar.clothe.libApi,
                                          items: getListItem(clotheType,snapshot.data),
                                          hint: new Text("select clothes"),
                                          onChanged: (value) {
                                            currentConfig
                                                    .currentUser.avatar.clothe =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, clotheType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.clotheColo.libApi,
                                          items: getListItem(clotheColor,snapshot.data),
                                          hint: new Text("clothes color"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .clotheColo =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, clotheColor[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig
                                              .currentUser.avatar.eye.libApi,
                                          items: getListItem(eyeType,snapshot.data),
                                          hint: new Text("select eyes"),
                                          onChanged: (value) {
                                            currentConfig
                                                    .currentUser.avatar.eye =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, eyeType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.eyebrow.libApi,
                                          items: getListItem(eyebrowType,snapshot.data),
                                          hint: new Text("select eyebrow"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .eyebrow =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, eyebrowType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig
                                              .currentUser.avatar.mouth.libApi,
                                          items: getListItem(mouthType,snapshot.data),
                                          hint: new Text("select mouth"),
                                          onChanged: (value) {
                                            currentConfig
                                                    .currentUser.avatar.mouth =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, mouthType[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      new DropdownButton(
                                          value: currentConfig.currentUser
                                              .avatar.skinColo.libApi,
                                          items: getListItem(skinColor,snapshot.data),
                                          hint: new Text("select skin"),
                                          onChanged: (value) {
                                            currentConfig.currentUser.avatar
                                                    .skinColo =
                                                SubAvatarItem
                                                    .getSubAvatarItemFrom(
                                                        value, skinColor[0]);
                                            setState(() {});
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              FlatButton(
                  onPressed: () {
                    User.modifyUserAvantarAndBadge(
                        currentConfig.currentUser.badge.name,
                        currentConfig.currentUser.badge.adj);
                    Navigator.pushNamed(context, core, arguments: {
                      "selectedIndex": 2,
                      "randosCollection": currentConfig.getCurrentRandoList()
                    });
                  },
                  child: Text("Save"))
            ]),
          );
        });
  }

  List<DropdownMenuItem<String>> getListItem(List<SubAvatarItem> itemList,List<String> unlockedAchievements) {
    List<DropdownMenuItem<String>> allItemForDropdown = [];
    for (SubAvatarItem item in itemList) {
      if (item.isUnlock ) {
        allItemForDropdown.add(new DropdownMenuItem(
          child: new Text(item.libUI),
          value: item.libApi,
        ));
      }
    }
    return allItemForDropdown;
  }

  getListName(List<NameTitle> nameList,List<String> unlockedAchievements) {
    List<DropdownMenuItem<String>> allNameForTitre = [];
    print(nameList);
    for (NameTitle name in nameList) {
      print(name.isUnlock);
      if (name.isUnlock  )
        allNameForTitre.add(new DropdownMenuItem(
          child: new Text(name.libName),
          value: name.libName,
        ));
    }
    return allNameForTitre;
  }

  getListAdjective(List<AdjectiveTitle> adjectiveList,List<String> unlockedAchievements) {
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

  List<String> getListOfUnlockedNameAndAdjectives(List<String> unlockedAchievements) {
    List<String> s=[];

    if(unlockedAchievements!=null) {
      if (unlockedAchievements.contains("6099839249627d1a70194095")) {

         s.add("Chèvre");


      }

      if (unlockedAchievements.contains("6099839249627d1a70194097")) {
        s.add("Bourrin");

      }
      if (unlockedAchievements.contains("6099839249627d1a70194098")) {
        s.add("Patron");

      }
      if (unlockedAchievements.contains("6099839249627d1a70194094")) {
        s.add("Hermite");

      }
      if (unlockedAchievements.contains("6099839249627d1a70194096")) {
        s.add("sans pitié");

      }
      if (unlockedAchievements.contains("6099839249627d1a70194093")) {
        s.add("optimiste");

      }
      if (unlockedAchievements.contains("60998f2649627d1a70194099")) {
        s.add("collectionneur");

      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77baf")) {
        s.add("maître");
      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77bb0")) {

      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77bb1")) {

      }
    }
    return s;
  }

  List<SubAvatarItem> getListOfUnlockedSubItems(List<String> unlockedAchievements) {
    List<SubAvatarItem> s=[];

    if(unlockedAchievements!=null) {
      if (unlockedAchievements.contains("6099839249627d1a70194095")) {
        s.add(SubAvatarItem("Eyepatch", "Cache oeil", false));

        s.add(SubAvatarItem("BeardMajestic", "Barbe longue", false));

        s.add(SubAvatarItem("Tongue", "Langue", false));
        s.add(SubAvatarItem("Vomit", "Vomi", false));
      }

      if (unlockedAchievements.contains("6099839249627d1a70194097")) {
        s.add(SubAvatarItem("Hijab", "Voile", false));
        s.add(SubAvatarItem("Turban", "Turban", false));


        s.add(SubAvatarItem("Grimace", "Grimace", false));
        s.add(SubAvatarItem("Sad", "Triste", false));
      }
      if (unlockedAchievements.contains("6099839249627d1a70194098")) {
        s.add(SubAvatarItem("WinterHat3", "Chapeau d'hiver 2", false));
        s.add(SubAvatarItem("LongHairBigHair", "Cheveux ondulés", false));
        s.add(SubAvatarItem("Wink", "Clin d'oeil", false));
      }
      if (unlockedAchievements.contains("6099839249627d1a70194094")) {
        s.add(SubAvatarItem("LongHairCurly", "Long cheveux bouclés", false));
        s.add(SubAvatarItem("LongHairDreads", "Dreadlocks", false));
        s.add(SubAvatarItem("ScreamOpen", "Cri", false));
        s.add(SubAvatarItem("Happy", "Joyeux", false));
      }
      if (unlockedAchievements.contains("6099839249627d1a70194096")) {
        s.add(SubAvatarItem("LongHairFroBand", "Coupe afro + bandeau", false));


        s.add(SubAvatarItem("ShirtVNeck", "T-Shirt V", false));

        s.add(SubAvatarItem("PastelRed", "Pastel", false));
      }
      if (unlockedAchievements.contains("6099839249627d1a70194093")) {
        s.add(SubAvatarItem("PastelYellow", "Jaune", false));

        s.add(SubAvatarItem("Squint", "Peur", false));
        s.add(SubAvatarItem("Side", "Coté", false));
      }
      if (unlockedAchievements.contains("60998f2649627d1a70194099")) {
        s.add(SubAvatarItem("Gray02", "Gris", false));
        s.add(SubAvatarItem("EyeRoll", "Révulsés", false));
        s.add(SubAvatarItem("ShortHairCaesarSidePart", "court stylé", false));
      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77baf")) {
        s.add(SubAvatarItem("MoustacheMagnum", "Moustache +", false));
        s.add(SubAvatarItem("CollarSweater", "Collar Sweater", false));
      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77bb0")) {
        s.add(SubAvatarItem(
            "LongHairShavedSides", "long et rasés sur les côtés", false));
        s.add(SubAvatarItem("Prescription01", "Prescription", false));
      }
      if (unlockedAchievements.contains("60b26b19ad64d61c84e77bb1")) {
        s.add(SubAvatarItem("Prescription01", "Lunettes de soleil", false));
        s.add(SubAvatarItem("GraphicShirt", "T-Shirt", false));
        s.add(SubAvatarItem("AngryNatural", "AngryNatural", false));
      }
    }
    return s;
  }
}
