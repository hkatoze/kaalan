import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/bookDetailsPage/components/bookImageSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/bookMetadataSection.dart';
import 'package:kaalan/views/bookDetailsPage/components/descriptionSection.dart';

class Body extends StatelessWidget {
  const Body({super.key, required this.book, required this.user});
  final BookModel book;
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
                  BookImageSection(
                    book: book,
                    user:user
                  ),
                  BookMetadataSection(
                    book: book,
                    isBook: true,
                  ),
                  DescriptionSection(
                    book: book,
                    isBook: true,
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
