import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/views/onboardingPage/components/sign_in_dialog.dart';

class SocialLoginBtn extends StatefulWidget {
  const SocialLoginBtn(
      {Key? key, required this.formsController, required this.headerController})
      : super(key: key);

  final PageController formsController;
  final PageController headerController;

  @override
  State<SocialLoginBtn> createState() => _SocialLoginBtnState();
}

class _SocialLoginBtnState extends State<SocialLoginBtn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "OU",
                style: TextStyle(
                  color: Colors.black26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(child: Divider()),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 15),
          child: Text(
            "S'enregistrer avec Email, Apple ou Google",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  widget.formsController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                  widget.headerController.animateToPage(1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                },
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  "assets/icons/email_box.svg",
                  height: 64,
                  width: 64,
                ),
              ),
              IconButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  "assets/icons/apple_box.svg",
                  height: 64,
                  width: 64,
                ),
              ),
              IconButton(
                onPressed: () {
                  signInWithGoogle(context);
                },
                padding: EdgeInsets.zero,
                icon: SvgPicture.asset(
                  "assets/icons/google_box.svg",
                  height: 64,
                  width: 64,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}