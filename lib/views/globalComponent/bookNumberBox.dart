import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class BookNumberBox extends StatelessWidget {
  const BookNumberBox({super.key, required this.number, required this.total});
  final int number;
  final int total;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: "Livre ",
            style: TextStyle(fontFamily: "Nominee", color: ksecondaryTextColor),
            children: <TextSpan>[
          TextSpan(text: "${number} ", style: TextStyle(color: Colors.black)),
          TextSpan(text: "sur ${total}")
        ]));
  }
}
