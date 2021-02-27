import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class FilterSlider extends StatefulWidget {
  FilterSlider({Key key}) : super(key: key);

  @override
  _FilterSliderState createState() => _FilterSliderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _FilterSliderState extends State<FilterSlider> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _currentSliderValue,
          min: 0,
          max: 50,
          divisions: 10,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "0 km",
            ),
            Text(
              "50 km"
            )
          ],
        )
      ],
    );
  }
}
