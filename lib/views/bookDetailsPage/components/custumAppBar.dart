import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

AppBar CustumAppBar(String title) {
  return AppBar(
    backgroundColor: kbgColor,
    elevation: 0,
    leading: InkWell(
      onTap: () {},
      child: Container(
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
      style: TextStyle(
          fontFamily: "Nominee",
          fontWeight: FontWeight.bold,
          color: Colors.black),
    ),
    centerTitle: true,
    actions: [
      InkWell(
        onTap: () {},
        child: Container(
          width: 50,
          height: 50,
          child: Center(
              child: Icon(
            Icons.more_horiz,
            color: Colors.black,
          )),
        ),
      ),
    ],
  );
}
