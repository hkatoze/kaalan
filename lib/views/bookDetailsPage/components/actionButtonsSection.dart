import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/bookDetailsPage/bookDetailsPage.dart';
import 'package:kaalan/views/bookReaderPage/bookReaderPage.dart';
import 'package:page_transition/page_transition.dart';

class ActionButtonsSection extends StatefulWidget {
  const ActionButtonsSection({
    super.key,
    required this.book,
    required this.user,
  });
  final BookModel book;

  final UserModel user;

  @override
  State<ActionButtonsSection> createState() => _ActionButtonsSectionState();
}

class _ActionButtonsSectionState extends State<ActionButtonsSection> {
  bool isInLibrary = false;

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<BookModel> libraryBooks = await fetchLibraryBooks(widget.user.id);

    var libraryBooksid = libraryBooks.map((e) => e.id);

    try {
      setState(() {
        isInLibrary = libraryBooksid.contains(widget.book.id);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 2,
        right: 10,
        left: 10,
        child: Container(
          color: kbgColor,
          height: 80,
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () async {
                if (isInLibrary) {
                  AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.info,
                      btnCancelText: "ANNULER",
                      btnCancelColor: ksecondaryColor,
                      btnOkText: "RETIRER",
                      btnOkColor: kprimaryColor,
                      body: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Voulez vous vraiment retirer ce livre de votre bibliothèque? Vous perdrez toute votre progression.",
                          style: TextStyle(fontFamily: "Nominee"),
                        ),
                      ),
                      btnOkOnPress: () async {
                        String response = await removeToLibrary(
                            widget.user.id, widget.book.id);
                        if (response == "Livre retiré de votre bibliothèque.") {
                          setState(() {
                            isInLibrary = false;
                          });
                        }
                        Fluttertoast.showToast(
                            msg: response,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 7,
                            backgroundColor: response ==
                                    "Livre retiré de votre bibliothèque."
                                ? Colors.green
                                : Colors.red,
                            textColor: Colors.white,
                            fontSize: 14.0);
                      },
                      btnCancelOnPress: () {
                        Navigator.canPop(context);
                      }).show();
                } else {
                  String response =
                      await addToLibrary(widget.user.id, widget.book.id,1);
                  Fluttertoast.showToast(
                      msg: response,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 7,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 14.0);
                  setState(() {
                    isInLibrary = true;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: ksecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.favorite,
                      color: isInLibrary ? ksecondaryColor : Colors.grey,
                    )),
              ),
            ),
            SizedBox(
                width: kwidth(context, 0.7),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeftJoined,
                            childCurrent: BookDetailsPage(
                              book: widget.book,
                              user: widget.user,
                            ),
                            child: BookReaderPage(
                              book: widget.book,
                              user: widget.user,
                            )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        isInLibrary ? 'Continuer à lire' : "Lire",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Nominee",
                            fontWeight: FontWeight.bold),
                      )),
                )),
          ]),
        ));
  }
}
