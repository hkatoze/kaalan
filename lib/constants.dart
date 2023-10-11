import 'package:flutter/material.dart';

Color kprimaryColor = const Color(0xFF233973);
Color ksecondaryColor = const Color(0xFFE98D6F);
Color kbgColor = const Color(0xFFFBFBFC);
Color kprimaryTextColor = const Color(0xFF233973);
Color ksecondaryTextColor = const Color(0xFFABADB6);

double kheight(BuildContext context, double value) =>
    MediaQuery.of(context).size.height * value;
double kwidth(BuildContext context, double value) =>
    MediaQuery.of(context).size.width * value;
