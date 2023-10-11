import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/searchpage/components/authorsSection.dart';

import 'package:kaalan/views/searchpage/components/recentQueriesSection.dart';
import 'package:kaalan/views/searchpage/components/searchbar.dart';

import 'package:kaalan/views/searchpage/components/topBookSection.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: searchBar(),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: const SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  RecentQueriesSection(),
                  TopBookSection(),
                  AuthorsSection()
                ],
              ))),
    );
  }
}
