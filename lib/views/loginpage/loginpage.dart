import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/apiResponseModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/services/firebaseservices.dart';
import 'package:kaalan/views/forgotPassword/forgotPassword.dart';
import 'package:kaalan/views/mainpage/mainpage.dart';
import 'package:kaalan/views/signuppage/signuppage.dart';
import 'package:page_transition/page_transition.dart';

class Loginpage extends StatefulWidget {
  final String? email;
  final String? password;

  const Loginpage({super.key, this.email, this.password});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLogin = false;

  void initState() {
    super.initState();
    initAuthValues();
  }

  void initAuthValues() {
    if (widget.email != null && widget.password != null) {
      setState(() {
        _emailController.text = widget.email.toString();
        _passwordController.text = widget.password.toString();
      });
    }
  }

  Future<void> login() async {
    setState(() {
      _isLogin = true;
    });
    ApiResponseModel response =
        await loginAPI(_emailController.text, _passwordController.text);

    var value = response.data;
    setState(() {
      _isLogin = false;
    });

    if (response.message == "L'utilisateur s'est connecté avec succès.") {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 300),
              childCurrent: const Loginpage(),
              reverseDuration: const Duration(milliseconds: 300),
              child: Mainpage(
                logedUser: UserModel(
                  id: value!['id'],
                  emailAddress: value['emailAddress'],
                  phone: value['phone'],
                  username: value['username'],
                  role: value['role'],
                  password: _passwordController.text,
                  firstname: value['firstname'],
                  lastname: value['lastname'],
                ),
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

  Future<void> signingWithGoogle() async {
    UserCredential user = await AuthService().signingWithGoogleByFirebase();
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {},
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kprimaryColor),
            ),
          ),
        );
      },
    );
    ApiResponseModel registerResponse = await registerToAPI(
        user.user!.email!, "fromGoogle", null, user.user!.displayName!);

    if (registerResponse.message == "Compte crée avec succès!") {
      ApiResponseModel loginResponse =
          await loginAPI(registerResponse.data!['emailAddress'], "fromGoogle");

      var value = loginResponse.data;
      Navigator.pop(context);

      if (loginResponse.message ==
          "L'utilisateur s'est connecté avec succès.") {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                duration: const Duration(milliseconds: 300),
                childCurrent: const Loginpage(),
                reverseDuration: const Duration(milliseconds: 300),
                child: Mainpage(
                  logedUser: UserModel(
                    id: value!['id'],
                    emailAddress: value['emailAddress'],
                    phone: value['phone'],
                    username: value['username'],
                    role: value['role'],
                    password: _passwordController.text,
                    firstname: value['firstname'],
                    lastname: value['lastname'],
                  ),
                )));
      } else {
        Fluttertoast.showToast(
            msg: "${loginResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else if (registerResponse.message ==
        "L'adresse email fournit est déjà utilisé.") {
      ApiResponseModel loginResponse =
          await loginAPI(user.user!.email!, "fromGoogle");

      var value = loginResponse.data;
      setState(() {
        _isLogin = false;
      });

      if (loginResponse.message ==
          "L'utilisateur s'est connecté avec succès.") {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                duration: const Duration(milliseconds: 300),
                childCurrent: const Loginpage(),
                reverseDuration: const Duration(milliseconds: 300),
                child: Mainpage(
                  logedUser: UserModel(
                    id: value!['id'],
                    emailAddress: value['emailAddress'],
                    phone: value['phone'],
                    username: value['username'],
                    role: value['role'],
                    password: _passwordController.text,
                    firstname: value['firstname'],
                    lastname: value['lastname'],
                  ),
                )));
      } else {
        Fluttertoast.showToast(
            msg: "${loginResponse.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "${registerResponse.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {
      _isLogin = false;
    });
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
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  scale: 3.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "Connexion",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre adresse mail";
                            }
                            return null;
                          },
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
                          controller: _passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Entrer votre mot de passe";
                            }
                            return null;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
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
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftJoined,
                                  duration: const Duration(milliseconds: 300),
                                  childCurrent: const Loginpage(),
                                  reverseDuration:
                                      const Duration(milliseconds: 300),
                                  child: Forgotpage()));
                        },
                        child: Text(
                          "Mot de passe oublié?",
                          style: TextStyle(color: Colors.black),
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
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 48,
                    child: _isLogin
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

                                await login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kprimaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                )),
                            child: const Text("Se connecter"),
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 1,
                        color: Colors.grey,
                      ),
                      Text(
                        "Ou",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: 1,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(children: [
                    InkWell(
                        onTap: () {
                          signingWithGoogle();
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(children: [
                              Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      "assets/images/g.png",
                                      scale: 7,
                                    )),
                              ),
                              Text(
                                "Se connecter avec Google",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ]),
                          ),
                        )),
                    InkWell(
                        onTap: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(children: [
                              Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Image.asset(
                                      "assets/images/f.png",
                                      scale: 7,
                                    )),
                              ),
                              Text(
                                "Se connecter avec Facebook",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ]),
                          ),
                        )),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Je n'ai pas de compte?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftJoined,
                                  duration: const Duration(milliseconds: 300),
                                  childCurrent: const Loginpage(),
                                  reverseDuration:
                                      const Duration(milliseconds: 300),
                                  child: Signuppage()));
                        },
                        child: Text(
                          "S'enregistrer",
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
