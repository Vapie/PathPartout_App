import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LoadImage extends StatelessWidget {
  String url;

  LoadImage(String url){
    this.url = url;
  }


  @override
  Widget build(BuildContext context){
    return CachedNetworkImage(
      // placeholder: (context, url) => CircularProgressIndicator(),
      imageUrl: this.url,
      progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}