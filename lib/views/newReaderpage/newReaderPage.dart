
import 'package:flutter/material.dart';

import 'package:kaalan/constants.dart';
import 'package:kaalan/models/newsModel.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';
import 'package:kaalan/views/newReaderpage/webview_page.dart';

import 'package:page_transition/page_transition.dart';

class NewReaderPage extends StatefulWidget {
  const NewReaderPage({
    super.key,
    required this.newItem,
  });
  final NewsModel newItem;

  @override
  State<NewReaderPage> createState() => _NewReaderPageState();
}

class _NewReaderPageState extends State<NewReaderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: CustumAppBar(widget.newItem.title, context),
      body: Container(
        height: kheight(context, 0.9),
        margin: const EdgeInsets.only(bottom: 25),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                height: 280,
                width: kwidth(context, 0.9),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.newItem.urlToImage)),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: kwidth(context, 0.1),
                        vertical: 20),
                    child: Column(children: <Widget>[])),
              ),
            ),
            Positioned(
                bottom: 5,
                right: kwidth(context, 0.05),
                left: kwidth(context, 0.05),
                child: Container(
                  width: kwidth(context, 0.9),
                  height: 420,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                        Text(
                          widget.newItem.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Nominee",
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.newItem.description,
                          style: TextStyle(
                              fontFamily: "Nominee",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          widget.newItem.content,
                          style: TextStyle(
                            fontFamily: "Nominee",
                            fontSize: 14,
                          ),
                        ),
                         const SizedBox(
                          height: 70,
                        ),
                      ])),
                )),
            Positioned(
                bottom: 1,
                right: 10,
                left: 10,
                child: Container(
                  color: kbgColor,
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: SizedBox(
                      width: kwidth(context, 0.7),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftJoined,
                                  childCurrent:
                                      NewReaderPage(newItem: widget.newItem),
                                  child: WebviewPage(
                                    newItem: widget.newItem,
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kprimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // <-- Radius
                          ),
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Lire tout l'article",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Nominee",
                                  fontWeight: FontWeight.bold),
                            )),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
