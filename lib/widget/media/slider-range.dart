import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class FilterSlider extends StatefulWidget {
  double distanceMax;
  double distanceMin;

  FilterSlider({Key key}) : super(key: key);

  @override
  _FilterSliderState createState() => _FilterSliderState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _FilterSliderState extends State<FilterSlider> {
  RangeValues _currentRangeValues = const RangeValues(5, 15);

  double distanceMin(){
    widget.distanceMin = _currentRangeValues.start.toDouble();
  }

  double distanceMax(){
    widget.distanceMax = _currentRangeValues.end.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 50,
          divisions: 10,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              this.distanceMin();
              this.distanceMax();
              _currentRangeValues = values;
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
