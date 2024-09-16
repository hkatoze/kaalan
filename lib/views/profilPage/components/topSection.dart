import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/profilPage/components/editBtn.dart';
import 'package:kaalan/views/profilPage/components/statsInfos.dart';
import 'package:kaalan/views/profilPage/components/userInfosSection.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: kwidth(context, 0.9),
        decoration: BoxDecoration(
          color: kprimaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Container(
            margin: EdgeInsets.symmetric(
                horizontal:20,
                vertical: 50),
            child: Column(children: <Widget>[
              UserInfos(
                logedUser: widget.logedUser,
              ),
              StatsInfos(
                logedUser: widget.logedUser,
              ),
              if (MediaQuery.of(context).size.width < 420) const EditBtn()
            ])),
      ),
    );
  }
}
