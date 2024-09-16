import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';
 
import 'package:kaalan/views/loginpage/loginpage.dart';
 
import 'package:page_transition/page_transition.dart';

class ChangePasswordPage extends StatefulWidget {
  final String? email;
  final String? code;

  const ChangePasswordPage({super.key, this.email, this.code});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _password;
  bool _isSend = false;

  void initState() {
    super.initState();
  }

  Future<void> changePassword() async {
    setState(() {
      _isSend = true;
    });
    ApiResponseModel response = await checkCodeForResetPassword(
        widget.email!, widget.code!, _password!);
    setState(() {
      _isSend = false;
    });

    if (response.message ==
        "Votre mot de passe a été réinitialisé avec succès.") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightJoined,
              duration: const Duration(milliseconds: 300),
              childCurrent: const ChangePasswordPage(),
              reverseDuration: const Duration(milliseconds: 300),
              child: Loginpage(
                email: widget.email,
                password: _password,
              )));
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
      appBar: CustumAppBar("Changement de mot de passe", context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  scale: 3.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(8),
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
                            Icons.lock,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer le nouveau mot de passe";
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Nouveau Mot de passe",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(8),
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
                            Icons.lock,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Confirmer le nouveau mot de passe";
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: "Confirmer le mot de passe",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
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
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                // Appeler la méthode d'authentification ici avec _email et _password

                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Les mots de passe ne se concordent pas",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  await changePassword();
                                }
                              }
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
              ],
            ))),
      ),
    );
  }
}
