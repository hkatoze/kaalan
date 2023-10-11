import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: kheight(context, 0.3),
        width: kwidth(context, 0.9),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: kwidth(context, 0.1),
                vertical: kheight(context, 0.05)),
            child: Column(children: <Widget>[
              const Text(
                "Hello, Jelly!",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: "Nominee",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Which book suits your current mood?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: ksecondaryTextColor,
                  fontFamily: "Nominee",
                ),
              )
            ])),
      ),
    );
  }
}
