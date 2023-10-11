import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/testValues.dart';
import 'package:kaalan/views/globalComponent/bookNumberBox.dart';
import 'package:kaalan/views/homepage/components/bookItem.dart';

class BookImageSection extends StatelessWidget {
  const BookImageSection({super.key});

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
        BookItem(
          book: booksList[0],
          withNote: false,
        ),
        SizedBox(
          height: kheight(context, 0.03),
        ),
      ],
    );
  }
}
