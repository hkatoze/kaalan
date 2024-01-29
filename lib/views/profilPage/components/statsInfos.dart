import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/profilPage/components/editBtn.dart';

class StatsInfos extends StatefulWidget {
  const StatsInfos({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<StatsInfos> createState() => _StatsInfosState();
}

class _StatsInfosState extends State<StatsInfos> {
  @override
  Widget build(BuildContext context) {
    double minWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: kheight(context, 0.03)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "7",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  "Livres ouverts",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "3",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  "Livres terminés",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ]),
          if (minWidth >= 420) const EditBtn()
        ],
      ),
    );
  }
}
