import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

AppBar CustumAppBar(String title, BuildContext context) {
  return AppBar(
    backgroundColor: kbgColor,
    elevation: 0,
    leading: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Center(
            child: Icon(
          defaultTargetPlatform == TargetPlatform.iOS
              ? Icons.arrow_back_ios
              : Icons.arrow_back,
          color: Colors.black,
        )),
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(
          fontFamily: "Nominee",
          fontWeight: FontWeight.bold,
          color: Colors.black,fontSize: 20),
    ),
    centerTitle: true,
    actions: [
       
    ],
  );
}
