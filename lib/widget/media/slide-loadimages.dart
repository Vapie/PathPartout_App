import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'loadimage.dart';

// ignore: must_be_immutable
class SlideLoadImage extends StatelessWidget {
  List<dynamic> images;
  double width;
  double height;

  SlideLoadImage(images, double width, double height) {
    this.images = images;
    this.width = width;
    this.height = height;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        child: new Swiper(
          outer: false,
          itemBuilder: (c, i) {
            return LoadImage(images[i]);
          },
          pagination: new SwiperPagination(margin: new EdgeInsets.all(0.0)),
          itemCount: images.length,
        ),
        constraints: new BoxConstraints.loose(new Size(width, height)));
  }
}
