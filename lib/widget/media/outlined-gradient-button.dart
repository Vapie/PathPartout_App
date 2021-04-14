import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OutlinedGradientButton extends StatelessWidget {
  final Widget children;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const OutlinedGradientButton({
    Key key,
    @required this.children,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final innerDecoration = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(8),
    );

    final gradientBoxDecoration = BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.lightBlue, Colors.lightGreenAccent[100]]),
      borderRadius: BorderRadius.circular(10),
    );

    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.lightBlue, Colors.lightGreenAccent[100]],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [children],
                ),
                decoration: innerDecoration,
              ),
            ),
            onTap: onPressed,
        ),
      ),
      width: width,
      height: 66.0,
      decoration: gradientBoxDecoration,
    );
  }
}
