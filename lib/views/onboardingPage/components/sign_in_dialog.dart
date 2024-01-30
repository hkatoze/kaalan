import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 
import 'package:fluttertoast/fluttertoast.dart';
 
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/services/firebaseservices.dart';
import 'package:kaalan/views/mainpage/mainpage.dart';
import 'package:kaalan/views/onboardingPage/components/register_form.dart';
 

import 'sign_in_form.dart';

Future<Map<String, dynamic>> logical(
  String email,
  String password,
  String phone,
  String username,
  String firstname,
  String lastname,
) async {
  ApiResponseModel response = await registerToAPI(
      email, password, phone, username, firstname, lastname);

  if (response.message == "Compte crée avec succès!") {
    return {"result": true, "user": response.data};
  } else {
    Fluttertoast.showToast(
        msg: "${response.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return {"result": false, "user": {}};
  }
}

signInWithGoogle(BuildContext context) async {
  UserCredential user = await AuthService().signingWithGoogleByFirebase();
  logical(user.user!.email!, "fromGoogle", "fromGoogle", "fromGoogle", ".",
          user.user!.displayName!)
      .then((value) {
    if (value['result'] == true) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Future.delayed(const Duration(seconds: 1), () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Mainpage(
                  logedUser: UserModel(
                    id: value['user']['id'],
                    emailAddress: value['user']['emailAddress'],
                    phone: value['user']['phone'],
                    username: value['user']['username'],
                    role: value['user']['role'],
                    password: "fromGoogle",
                    firstname: value['user']['firstname'],
                    lastname: value['user']['lastname'],
                  ),
                ),
              ),
            );
          });
        },
      );
    } else {}
  });
}

void showCustomDialog(BuildContext context, {required ValueChanged onClosed}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (_, __, ___) {
      return SigninDialogContent();
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      // if (anim.status == AnimationStatus.reverse) {
      //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      // } else {
      //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      // }

      tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        // child: FadeTransition(
        //   opacity: anim,
        //   child: child,
        // ),
        child: child,
      );
    },
  ).then(onClosed);
}

class SigninDialogContent extends StatefulWidget {
  const SigninDialogContent({super.key});

  @override
  State<SigninDialogContent> createState() => _SigninDialogContentState();
}

class _SigninDialogContentState extends State<SigninDialogContent> {
  final _formsController = PageController();
  final _headerController = PageController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 670,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),
        child: Scaffold(
          // backgroundColor: Colors.transparent,
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 163,
                      child: PageView(
                        controller: _headerController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              const Text(
                                "Connexion",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 15),
                                child: Text(
                                  "100% GRATUIT, lisez, explorez et découvrez des histoires sans fin. Rejoignez-nous pour une expérience de lecture inégalée.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                "Enregistrement",
                                style: TextStyle(
                                  fontSize: 34,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 15),
                                child: Text(
                                  "Créer un compte gratuitement, et profiter au max de toute la bibliothèque disponible. Rejoignez-nous maintenant.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 460,
                      child: PageView(
                        controller: _formsController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SignInForm(
                            formsController: _formsController,
                            headerController: _headerController,
                          ),
                          RegisterForm(
                            formsController: _formsController,
                            headerController: _headerController,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: -50,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
