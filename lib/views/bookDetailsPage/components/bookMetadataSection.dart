import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/globalComponent/bookMetadataItem.dart';

class BookMetadataSection extends StatelessWidget {
  const BookMetadataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kwidth(context, 0.87),
      margin: EdgeInsets.only(
        bottom: kheight(context, 0.05),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFE1E6EF), Color(0xFFF7F9FD)]),
          borderRadius: BorderRadius.circular(10)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const BookMetadataItem(
          unit: "/5",
          value: "4.8",
          withIcon: true,
          icon: Icons.star,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: 1,
            height: 40,
            color: Colors.grey),
        const BookMetadataItem(
          unit: "read",
          value: "4,2k",
          withIcon: false,
        ),
        Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            width: 1,
            height: 40,
            color: Colors.grey),
        const BookMetadataItem(
          unit: "pages",
          value: "340",
          withIcon: false,
        ),
      ]),
    );
  }
}
