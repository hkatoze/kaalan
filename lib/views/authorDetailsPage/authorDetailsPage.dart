import 'package:flutter/material.dart';

import 'package:kaalan/constants.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/authorDetailsPage/components/bodyAuthorPage.dart';
 
import 'package:kaalan/views/bookDetailsPage/components/backgroundImage.dart';
import 'package:kaalan/views/bookDetailsPage/components/custumAppBar.dart';

class AuthorDetailsPage extends StatefulWidget {
  const AuthorDetailsPage(
      {super.key, required this.author,required this.user});
  final AuthorWithBookModel author;
  final UserModel user;
 

  @override
  State<AuthorDetailsPage> createState() => _AuthorDetailsPageState();
}

class _AuthorDetailsPageState extends State<AuthorDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: CustumAppBar(widget.author.author.name, context),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              BackgroundImage(
                img: widget.author.author.profilImg,
              ),
              BodyAuthorPage(
                author: widget.author,
                user: widget.user,
              ),
            ],
          )),
    );
  }
}
