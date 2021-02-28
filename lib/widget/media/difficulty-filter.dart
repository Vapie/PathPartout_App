import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DifficultyFilter extends StatefulWidget {
  @override
  _DifficultyFilterState createState() => _DifficultyFilterState();
}

class _DifficultyFilterState extends State<DifficultyFilter> {
  selected(element) {
    print(element.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextButton(
              onPressed: selected(this),
              child: Text("Facile", style: TextStyle(color: Colors.grey[500]))),
          TextButton(
              onPressed: selected(this),
              child: Text(
                "Intermédiaire",
                style: TextStyle(color: Colors.grey[500]),
              )),
          TextButton(
              onPressed: selected(this),
              child: Text(
                "Avancée",
                style: TextStyle(color: Colors.grey[500]),
              )),
        ],
      ),
    );
  }
}
