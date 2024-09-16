import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: 230,
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
              SizedBox(
                width: kwidth(context, 0.8),
                child: Text(
                  "Salut, ${logedUser.lastname}!",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Quel livre correspond à ton mood aujourd'hui?",
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
