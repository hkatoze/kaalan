import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/localdbservices.dart';

import 'package:kaalan/views/mainpage/mainpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kaalan/views/splashpage/spashpage.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.Max,
      )
    ],
    debug: true,
  );

  runApp(const KaalanApp());
}

class KaalanApp extends StatefulWidget {
  const KaalanApp({super.key});

  @override
  State<KaalanApp> createState() => _KaalanAppState();
}

class _KaalanAppState extends State<KaalanApp> {
  bool isConnect = false;
  UserModel? loggedUser;

  @override
  void initState() {
    super.initState();
    //logout();
    fetchUserInformation();
  }

  void logout() async {
    await DatabaseManager.instance.clearDatabase();
  }

  void fetchUserInformation() async {
    //await DatabaseManager.instance.deleteDb();
    final UserModel? loggedInUser =
        await DatabaseManager.instance.getLoggedUser();

    if (loggedInUser != null) {
      setState(() {
        isConnect = true;
        loggedUser = loggedInUser;
      });
    } else {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: kprimaryColor),
      home: isConnect ? Mainpage(logedUser: loggedUser!) : Onboarding(),
    );
  }
}
