import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/bookDetailsPage/components/actionButtonsSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/backgroundImage.dart';
import 'package:kaalan/views/bookDetailsPage/components/body.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';

class BookDetailsPage extends StatefulWidget {
  const BookDetailsPage(
      {super.key,
      required this.book,
      required this.user,
      });
  final BookModel book;

  final UserModel user;

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: CustumAppBar(widget.book.title, context),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              BackgroundImage(
                img: widget.book.cover,
              ),
              Body(book: widget.book, user: widget.user),
              ActionButtonsSection(
                book: widget.book,
                user: widget.user,
              )
            ],
          )),
    );
  }
}
