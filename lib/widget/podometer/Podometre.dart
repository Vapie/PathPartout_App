
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:pedometer/pedometer.dart';
/// This is the stateful widget that the main application instantiates.
class Podometre extends StatefulWidget {
  int steps = 0;

  Podometre({Key key}) : super(key: key);

  @override
  _PodometreState createState() => _PodometreState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PodometreState extends State<Podometre> {
  int initialValue = 0;


  double setStep(){
    widget.steps = _steps - initialValue;

  }


  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = "?";
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    widget.steps = 0;

    this.initialValue = 0;
    this.setStep();
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps;
      this.setStep();
      if (initialValue == 0){
        initialValue = _steps;
    }
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      print('Step Count not available');
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return Container(width: 0,height: 0);
  }
}

