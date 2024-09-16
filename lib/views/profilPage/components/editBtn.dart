import 'package:flutter/material.dart';

class EditBtn extends StatelessWidget {
  const EditBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: 120,
        decoration:
            BoxDecoration(border: Border.all(color: Colors.white, width: 0.5)),
        child: Center(
            child: Text(
          "MODIFIER PROFIL",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: "Nominee",
              fontSize: 12,
              color: Colors.white.withOpacity(0.5)),
        )),
      ),
    );
  }
}
