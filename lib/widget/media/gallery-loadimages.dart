import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'loadimage.dart';

// ignore: must_be_immutable
class GalleryLoadImage extends StatelessWidget {
  List<dynamic> images;
  double width;
  double height;


  GalleryLoadImage(images, double width, double height){
    this.images = images;
    this.width = width;
    this.height = height;
  }

  @override
  Widget build(BuildContext context){
    return
      ConstrainedBox(
          child: new Swiper(
            outer:false,
            itemBuilder: (c, i) {
              return LoadImage(images[i]);
            },
            pagination: new SwiperPagination(
                margin: new EdgeInsets.only(bottom: 10.0)
            ),
            itemCount: images.length,
            viewportFraction: 0.5,
            scale: 0.5,
          ),
          constraints:new BoxConstraints.loose(new Size(width, height))
    );
  }
}