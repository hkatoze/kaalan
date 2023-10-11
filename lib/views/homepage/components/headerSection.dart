import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/homepage/components/readingReminderSection.dart';
import 'package:kaalan/views/homepage/components/welcomeSection.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kheight(context, 0.48),
      margin: EdgeInsets.only(bottom: 25),
      child: Stack(
        children: <Widget>[WelcomeSection(), ReadingReminderSection()],
      ),
    );
  }
}
