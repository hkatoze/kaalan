import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/userModel.dart';

import 'package:kaalan/views/globalComponent/bookNumberBox.dart';

import 'package:kaalan/views/searchpage/components/authorItem.dart';

class AuthorImageSection extends StatelessWidget {
  const AuthorImageSection(
      {super.key, required this.author, required this.user});
  final AuthorWithBookModel author;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kheight(context, 0.01),
        ),
        const BookNumberBox(number: 3, total: 4),
        SizedBox(
          height: kheight(context, 0.02),
        ),
        AuthorItem(
          author: author,
          big: true,
          user: user,
          isSimpleImage: true,
        ),
        SizedBox(
          height: kheight(context, 0.03),
        ),
      ],
    );
  }
}
