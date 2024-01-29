import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class BackgroundImage extends StatelessWidget {
  final String img;
  const BackgroundImage({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
      height: kheight(context, 0.7),
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(img))),
    ));
  }
}
