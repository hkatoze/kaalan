import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/authorDetailsPage/components/authorImageSection.dart';

import 'package:kaalan/views/bookDetailsPage/components/bookMetadataSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/descriptionSection.dart';

class BodyAuthorPage extends StatelessWidget {
  const BodyAuthorPage({super.key, required this.author, required this.user});
  final AuthorWithBookModel author;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        child: Container(
            height: kheight(context, 0.9),
            width: kwidth(context, 1),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                kbgColor.withOpacity(0.95),
              ],
            )),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AuthorImageSection(
                    author: author,
                    user: user,
                  ),
                  BookMetadataSection(
                    author: author,
                    isBook: false,
                  ),
                  DescriptionSection(
                    author: author,
                    isBook: false,
                    user: user,
                  ),
                  SizedBox(
                    height: kheight(context, 0.1),
                  )
                ],
              ),
            )));
  }
}
