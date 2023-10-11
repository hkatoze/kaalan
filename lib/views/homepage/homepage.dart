import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/homepage/components/bookListSection.dart';
import 'package:kaalan/views/homepage/components/categorySection.dart';
import 'package:kaalan/views/homepage/components/headerSection.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbgColor,
        body: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                HeaderSection(),
                CategorySection(),
                BookListSection()
              ],
            )));
  }
}
