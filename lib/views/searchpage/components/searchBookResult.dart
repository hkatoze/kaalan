import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:kaalan/constants.dart";
import "package:kaalan/models/bookModel.dart";
import "package:kaalan/models/searchQueryModel.dart";
import "package:kaalan/models/userModel.dart";
import "package:kaalan/services/apiservices.dart";
import "package:kaalan/services/localdbservices.dart";
import "package:kaalan/views/homepage/components/bookItem.dart";
import 'dart:async';

class SearchBooksResult extends StatefulWidget {
  const SearchBooksResult({Key? key, required this.query, required this.user})
      : super(key: key);
  final TextEditingController query;
  final UserModel user;

  @override
  State<SearchBooksResult> createState() => _SearchBooksResultState();
}

class _SearchBooksResultState extends State<SearchBooksResult> {
  List<BookModel> filteredBooks = [];
  List<BookModel> allBooks = [];

  @override
  void initState() {
    super.initState();
    fetchInitBooks();
    widget.query.addListener(fetchData);
  }

  Future<void> fetchInitBooks() async {
    List<BookModel> allBooksFetched = await fetchAllBooks();
    try{
      setState(() {
      allBooks = allBooksFetched;
    });
    } catch(e){
      
    }
  }

  void fetchData() {
    filteredBooks.clear();
    List<BookModel> fetchedBooks = searchBooks(widget.query.text);
    setState(() {
      filteredBooks = fetchedBooks;
    });
  }

  List<BookModel> searchBooks(String query) {
    if (query != "") {
      for (BookModel book in allBooks) {
        if (book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query)) {
          filteredBooks.add(book);
        }
      }
    }

    return filteredBooks;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(),
            GestureDetector(
              onTap: () async {
                await DatabaseManager.instance
                    .addQuery(SearchQueryModel(query: widget.query.text));
                widget.query.clear();
              },
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    "Fermer",
                    style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 13,
                      color: widget.query.text == ""
                          ? Colors.transparent
                          : kprimaryColor,
                    ),
                  )),
            )
          ]),
        ),
        AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.bounceInOut,
            padding: EdgeInsets.only(bottom: kheight(context, 0.32), top: 10),
            width: double.infinity,
            height: widget.query.text == "" ? 0 : kheight(context, 1),
            decoration: const BoxDecoration(),
            child: filteredBooks.isEmpty
                ? Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/empty.svg",
                            semanticsLabel: 'Acme Logo',
                            height: 80,
                          ),
                          SizedBox(
                            height: kheight(context, 0.03),
                          ),
                          const Text(
                            "Aucun livre trouvé",
                            style:
                                TextStyle(fontFamily: "Nominee", fontSize: 13),
                          )
                        ]),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 0.5),
                    itemCount: filteredBooks.length,
                    itemBuilder: (context, index) {
                      BookModel book = filteredBooks[index];
                      return BookItem(
                        book: book,
                        user: widget.user,
                        withNote: true,
                        small: true,
                        smallest: true,
                      );
                    },
                  ))
      ],
    );
  }

  @override
  void dispose() {
    widget.query.removeListener(fetchData);
    super.dispose();
  }
}
