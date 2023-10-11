import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kheight(context, 0.03)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Nominee", fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Container()
      ]),
    );
  }
}
