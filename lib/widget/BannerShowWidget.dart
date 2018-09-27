import 'package:barber_app/utils/WindowUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BannerShowWidget extends StatelessWidget {
  BannerShowWidget({this.picUrl});

  final String picUrl;

  @override
  Widget build(BuildContext context) {
    return new CachedNetworkImage(
      imageUrl: picUrl,
      fit: BoxFit.fill,
      width: WindowUtils.getScreenWidth(),
    );
  }
}
