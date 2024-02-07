import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';
import 'package:kaalan/views/checkingCode/checkingCodePage.dart';
import 'package:page_transition/page_transition.dart';

class Forgotpage extends StatefulWidget {
  const Forgotpage({Key? key}) : super(key: key);

  @override
  State<Forgotpage> createState() => _ForgotpageState();
}

class _ForgotpageState extends State<Forgotpage> {
  bool emailIsValid = false;
  bool startMailEdit = false;
  bool _isSend = false;
  TextEditingController _emailController = TextEditingController();

  void initState() {
    super.initState();
    _emailController.addListener(_checkEmail);
  }

  _checkEmail() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);

    if (emailValid)
      setState(() {
        emailIsValid = true;
      });
    else {
      setState(() {
        emailIsValid = false;
      });
    }
  }

  Future<void> sendCode() async {
    setState(() {
      _isSend = true;
    });

    ApiResponseModel response = await resetPassword(_emailController.text);
    setState(() {
      _isSend = false;
    });

    if (response.message ==
        "Un code de vérification a été envoyé à votre adresse e-mail.") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 500),
              child: CheckingCodePage(
                email: _emailController.text,
                code: "${response.data!["verificationCode"]}",
              ),
              childCurrent: Forgotpage()));
    } else {
      Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: CustumAppBar("Mot de passe oublié", context),
      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(16),
          child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                Image.asset(
                  "assets/images/logo.png",
                  scale: 3.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "Entrer votre adresse mail afin de recevoir le code de vérification,pour réinitialiser votre mot de passe",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Nominee", fontSize: 17),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kprimaryColor.withOpacity(0.1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Icon(
                            Icons.email,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextField(
                          controller: _emailController,
                          onChanged: (value) {
                            setState(() {
                              startMailEdit = true;
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "adresse email",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: kheight(context, 0.005),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: kwidth(context, 0.06)),
                  child: Visibility(
                    visible: startMailEdit ? !emailIsValid : false,
                    child: Row(children: [
                      Text("Entrer une adresse email valide",
                          style: TextStyle(color: Colors.red))
                    ]),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 48,
                    child: _isSend
                        ? Stack(
                            children: [
                              Center(
                                child: SpinKitRotatingPlain(
                                  size: 20,
                                  duration: Duration(milliseconds: 1500),
                                  color: kprimaryColor,
                                ),
                              ),
                              SpinKitDualRing(
                                duration: Duration(milliseconds: 1500),
                                color: kprimaryColor,
                              )
                            ],
                          )
                        : ElevatedButton(
                            onPressed: emailIsValid
                                ? () async {
                                    if (emailIsValid) {
                                      sendCode();
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child:
                                const Text("Obtenir le code de vérification"),
                          ),
                  ),
                ),
                SizedBox(
                  height: kheight(context, 0.03),
                ),
                SizedBox(
                  height: kheight(context, 0.03),
                ),
              ]))),
    );
  }
}
