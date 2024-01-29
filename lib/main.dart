import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/localdbservices.dart';
import 'package:kaalan/views/mainpage/mainpage.dart';
import 'package:kaalan/views/onboardingPage/onboardingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      home: isConnect
          ? Mainpage(logedUser:loggedUser!)
          : const OnboardingPage(),
    );
  }
}
