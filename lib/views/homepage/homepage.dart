import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';

import 'package:kaalan/views/homepage/components/categorySection.dart';
import 'package:kaalan/views/homepage/components/headerSection.dart';
import 'package:kaalan/views/homepage/components/newsSection/newsSection.dart';
import 'package:kaalan/views/searchpage/components/authorsSection.dart';
import 'package:kaalan/views/searchpage/components/topBookSection.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key, required this.logedUser});
  final UserModel logedUser;

  final suggestionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgColor,
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: kheight(context, 0.03),
                ),
                HeaderSection(
                  logedUser: logedUser,
                ),
                CategorySection(
                  user: logedUser,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: TopBookSection(
                    title: "Top des livres les plus lus",
                    user: logedUser,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: AuthorsSection(
                    title: "Top des auteurs les plus lus",
                    limit: 0,
                    user: logedUser,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: const NewsSection(
                    title: "Actualité africaine",
                    limit: 0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: kwidth(context, 0.5),
                            child: Text(
                              "Vous avez une suggestion pour améliorer Kaalan, dites le nous.",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start,
                              maxLines: 4,
                            ),
                          ),
                          SizedBox(
                              width: kwidth(context, 0.4),
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.info,
                                   
                                    btnOkText: "ENVOYER",
                                    btnOkColor: kprimaryColor,
                                    
                                    body: Center(
                                      child: Card(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: suggestionController,
                                          maxLines: 8, //or null
                                          decoration: const InputDecoration
                                              .collapsed(
                                              hintText:
                                                  "Ecrivez votre suggestion ici"),
                                        ),
                                      )),
                                    ),
                                    btnOkOnPress: () async {
                                      bool response = await sendSuggestion(
                                          logedUser.id,
                                          suggestionController.text);

                                      Fluttertoast.showToast(
                                          msg: response
                                              ? "Suggestion envoyée\nMerci pour l'intéret accordé au projet."
                                              : "Impossible d'envoyer votre suggestion, réessayer.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 7,
                                          backgroundColor: response
                                              ? Colors.green
                                              : Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 14.0);
                                    },
                                  ).show();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kprimaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(7), // <-- Radius
                                  ),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      "SUGGESTION",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Nominee",
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
