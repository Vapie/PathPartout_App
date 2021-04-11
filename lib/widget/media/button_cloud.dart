import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm_flutter_app/widget/media/gradient-button.dart';

List<String> tags = [
  "belle vue",
  "dénivelé",
  "calme",
  "forêt",
  "ensoleillé",
  "à l'ombre",
  "vue pas ouf",
  "plaine",
  "aire de pique nique",
  "toilettes"
];

List<String> selectedTags = [];

class ButtonCloud extends StatefulWidget {
  @override
  _ButtonCloudState createState() => _ButtonCloudState();
}

class _ButtonCloudState extends State<ButtonCloud> {
  List<bool> hasBeenAdded = List.filled(tags.skip(1).length, false);


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        //TODO maybe viewmodel
        for (var i = 0; i < tags.skip(1).length; i++)
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: OutlinedButton(
              child:
              Text(tags[i + 1]),
              style: OutlinedButton.styleFrom(
                  primary: hasBeenAdded[i] ? Colors.lightBlue : Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  side: BorderSide(color: Colors.white, width: 1.0),
                backgroundColor: hasBeenAdded[i] ? Colors.white : Colors.transparent,
              ),
              onPressed: () {
                selectedTags.add(tags[i + 1]);
                print(selectedTags);
                setState(() {
                  hasBeenAdded[i] = !hasBeenAdded[i];
                });
              },
            ),
          ),
      ],
    );
  }
}
