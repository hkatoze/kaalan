import 'package:flutter/material.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/homepage/components/newHomeItem.dart';
 
import 'package:kaalan/views/homepage/components/welcomeSection.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      margin: const EdgeInsets.only(bottom: 25),
      child: Stack(
        children: <Widget>[
          WelcomeSection(
            logedUser: logedUser,
          ),
          NewHomeItem()
        ],
      ),
    );
  }
}
