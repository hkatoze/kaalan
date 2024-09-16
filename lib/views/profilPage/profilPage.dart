import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/profilPage/components/bodySection.dart';
import 'package:kaalan/views/profilPage/components/topSection.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgColor,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                  height: kheight(context, 0.9),
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Stack(
                    children: <Widget>[
                      TopSection(logedUser: widget.logedUser),
                      BodySection(
                        user: widget.logedUser,
                        key: UniqueKey(),
                      )
                    ],
                  ),
                )
              ],
            )));
  }
}
