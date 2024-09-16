import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/loginpage/loginpage.dart';

import 'package:page_transition/page_transition.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password, _name, _surname;
  bool _acceptPolicy = false;
  bool _isRegister = false;

  Future<void> register() async {
    setState(() {
      _isRegister = true;
    });
    ApiResponseModel response =
        await registerToAPI(_email!, _password!, _name!, _surname!);
    setState(() {
      _isRegister = false;
    });

    debugPrint("${response.message}");
    if (response.message == "Compte crée avec succès!") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.leftToRightJoined,
              duration: const Duration(milliseconds: 300),
              childCurrent: const Signuppage(),
              reverseDuration: const Duration(milliseconds: 300),
              child: Loginpage(
                email: _email,
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
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  scale: 3.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Création de compte",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
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
                            Icons.person,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre nom";
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Nom",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
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
                            Icons.person,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre prénom";
                            }
                            return null;
                          },
                          onSaved: (value) => _surname = value,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Prénom",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
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
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre adresse mail";
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
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
                            Icons.lock,
                            color: kprimaryColor.withOpacity(0.7),
                          )),
                      const SizedBox(width: 8),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre mot de passe";
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Mot de passe",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _acceptPolicy = !_acceptPolicy;
                          });
                        },
                        child: Checkbox(
                            value: _acceptPolicy,
                            onChanged: (value) {
                              setState(() {
                                _acceptPolicy = !_acceptPolicy;
                              });
                            }),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _acceptPolicy = !_acceptPolicy;
                          });
                        },
                        child: Text(
                          "J'accepte tous les ",
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _acceptPolicy = !_acceptPolicy;
                          });
                        },
                        child: Text(
                          "Termes & Conditions",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: _isRegister
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
                            onPressed: _acceptPolicy
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();

                                      await register();
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: const Text("S'enregistrer"),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "J'ai déjà un compte?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))),
      ),
    );
  }
}
