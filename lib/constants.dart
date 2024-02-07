import 'package:flutter/material.dart';

Color kprimaryColor = const Color(0xFFe69138);
Color ksecondaryColor = const Color(0xFF0582d2);
Color kbgColor = Color.fromARGB(255, 243, 243, 243);
Color kprimaryTextColor = Color.fromARGB(255, 255, 180, 99);
Color ksecondaryTextColor = Color.fromARGB(255, 45, 46, 53);

double kheight(BuildContext context, double value) =>
    MediaQuery.of(context).size.height * value;
double kwidth(BuildContext context, double value) =>
    MediaQuery.of(context).size.width * value;
