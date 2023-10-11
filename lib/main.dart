import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:kaalan/views/mainpage/mainpage.dart';

void main() {
  runApp(const KaalanApp());
}

class KaalanApp extends StatelessWidget {
  const KaalanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.android
        ? const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Mainpage(),
          )
        : (defaultTargetPlatform == TargetPlatform.iOS
            ? const CupertinoApp(
                debugShowCheckedModeBanner: false,
                home: Mainpage(),
              )
            : const MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Mainpage(),
              ));
  }
}
