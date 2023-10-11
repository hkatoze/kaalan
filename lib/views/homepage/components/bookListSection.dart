import 'package:flutter/material.dart';
import 'package:kaalan/views/homepage/components/bookItem.dart';
import 'package:kaalan/testValues.dart';

class BookListSection extends StatelessWidget {
  const BookListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemCount: booksList.length,
          itemBuilder: ((context, index) => BookItem(
                book: booksList[index],
                withNote: true,
              ))),
    );
  }
}
