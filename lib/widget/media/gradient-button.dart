import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GradientButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Function onPressed;

  const GradientButton({
    Key key,
    @required this.child,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        gradient:  LinearGradient(colors: [Colors.lightBlue, Colors.lightGreenAccent[100]]),
        borderRadius: BorderRadius.circular(10.0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}