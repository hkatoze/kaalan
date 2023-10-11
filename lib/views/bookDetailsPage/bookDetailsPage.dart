import 'package:flutter/material.dart';

import 'package:kaalan/constants.dart';
import 'package:kaalan/views/bookDetailsPage/components/actionButtonsSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/backgroundImage.dart';
import 'package:kaalan/views/bookDetailsPage/components/body.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage({super.key});

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: CustumAppBar(
        "Ther Melian: Discord",
      ),
      body: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              BackgroundImage(
                img: "assets/images/book-img.jpg",
              ),
              Body(),
              ActionButtonsSection()
            ],
          )),
    );
  }
}
