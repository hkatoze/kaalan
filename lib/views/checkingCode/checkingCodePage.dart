import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';

import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';
import 'package:kaalan/views/changePasswordPage/changePasswordPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CheckingCodePage extends StatefulWidget {
  const CheckingCodePage({Key? key, this.code, this.email}) : super(key: key);

  final String? code;
  final String? email;

  @override
  State<CheckingCodePage> createState() => _CheckingCodePageState();
}

class _CheckingCodePageState extends State<CheckingCodePage> {
  bool emailIsValid = false;
  bool startMailEdit = false;
  bool _isSend = false;
  TextEditingController _codeController = TextEditingController();

  void initState() {
    super.initState();
  }

  Future<void> checkingCode() async {
    setState(() {
      _isSend = true;
    });

    if (_codeController.text == widget.code!) {
      setState(() {
        _isSend = false;
      });
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: Duration(milliseconds: 500),
              reverseDuration: Duration(milliseconds: 500),
              child: ChangePasswordPage(
                email: widget.email,
                code: widget.code,
              ),
              childCurrent: CheckingCodePage()));
    } else {
      setState(() {
        _isSend = false;
      });
      Fluttertoast.showToast(
          msg: "Code invalide",
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
      appBar: CustumAppBar("Vérification du code", context),
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
                  "Entrer le code de vérification que vous avez reçu sur votre mail.",
                  style: TextStyle(
                      color: Colors.grey, fontFamily: "Nominee", fontSize: 17),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: PinCodeTextField(
                    controller: _codeController,
                    pinTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Nominee",
                        fontWeight: FontWeight.bold),
                    pinBoxColor: Color(0xFFcfa07f),
                    autofocus: true,
                    pinBoxOuterPadding: EdgeInsets.symmetric(horizontal: 5),
                    highlight: true,
                    highlightColor: kprimaryColor,
                    defaultBorderColor: Color(0xFFcfa07f),
                    hasTextBorderColor: Color(0xFFcfa07f),
                    highlightPinBoxColor: Color(0xFFcfa07f),
                    maxLength: 6,
                    pinBoxRadius: 12,
                    pinBoxHeight: 46,
                    pinBoxWidth: 46,
                    wrapAlignment: WrapAlignment.spaceBetween,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
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
                            onPressed: () async {
                              checkingCode();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: const Text("Valider"),
                          ),
                  ),
                ),
              ]))),
    );
  }
}
