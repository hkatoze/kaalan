import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/bookDetailsPage/components/bookImageSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/bookMetadataSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/descriptionSection.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
            height: kheight(context, 0.9),
            width: kwidth(context, 1),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                kbgColor.withOpacity(0.93),
              ],
            )),
            child: const SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  BookImageSection(),
                  BookMetadataSection(),
                  DescriptionSection()
                ],
              ),
            )));
  }
}
