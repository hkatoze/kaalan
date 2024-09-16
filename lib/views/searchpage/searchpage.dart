import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/searchpage/components/authorsSection.dart';
import 'package:kaalan/views/searchpage/components/recentQueriesSection.dart';
import 'package:kaalan/views/searchpage/components/searchBookResult.dart';
import 'package:kaalan/views/searchpage/components/topBookSection.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key, required this.user});
  final UserModel user;

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      appBar: searchBar(_searchController),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SearchBooksResult(
                query: _searchController,
                user: widget.user,
              ), // Passer la valeur actuelle de la recherche
              RecentQueriesSection(
                searchController: _searchController,
              ),
              TopBookSection(
                  title: "Top des livres les plus recherchés",
                  user: widget.user),
                AuthorsSection(
                title: "Top des auteurs recherchés",
                limit: 10,
                user: widget.user,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar searchBar(TextEditingController searchController) {
    return AppBar(
      backgroundColor: kbgColor,
      automaticallyImplyLeading: false,
      excludeHeaderSemantics: true,
      forceMaterialTransparency: true,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 90,
      title: TextField(
        controller: searchController,
        onChanged: (value) async {},
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800], fontFamily: "Nominee"),
          hintText: "titre, catégorie ou auteur......",
          fillColor: const Color.fromARGB(255, 244, 245, 246),
          prefixIconColor: Colors.grey,
        ),
      ),
    );
  }
}
