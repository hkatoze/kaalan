import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class BookMetadataItem extends StatelessWidget {
  final String value;
  final String unit;
  final bool withIcon;
  final IconData? icon;
  const BookMetadataItem(
      {super.key,
      required this.unit,
      required this.value,
      this.icon,
      required this.withIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          if (withIcon)
            Icon(
              icon,
              size: 20,
              color: Colors.yellow,
            ),
          RichText(
              text: TextSpan(
                  text: value,
                  style: const TextStyle(
                      fontFamily: "Nominee",
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  children: [
                TextSpan(
                    text: " ${unit}",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: ksecondaryTextColor))
              ]))
        ],
      ),
    );
  }
}
