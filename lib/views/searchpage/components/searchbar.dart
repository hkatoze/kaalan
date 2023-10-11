import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

AppBar searchBar() {
  return AppBar(
    backgroundColor: kbgColor,
    elevation: 0,
    title: TextField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1,
              )),
          filled: true,
          hintStyle: TextStyle(color: Colors.grey[800], fontFamily: "Nominee"),
          hintText: "Search titles, topics, or authors",
          fillColor: const Color.fromARGB(255, 244, 245, 246),
          prefixIconColor: Colors.grey),
    ),
  );
}
