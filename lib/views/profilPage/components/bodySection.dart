import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/globalComponent/bookLoadingItem.dart';
import 'package:kaalan/views/homepage/components/bookItem.dart';
import 'package:kaalan/views/searchpage/components/sectionTitle.dart';

class BodySection extends StatefulWidget {
  const BodySection({super.key, required this.user});
  final UserModel user;

  @override
  State<BodySection> createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  List<BookModel> books = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<BookModel> fetchedBooks = await fetchLibraryBooks(widget.user.id);

    try {
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 250,
        right: kwidth(context, 0.02),
        left: kwidth(context, 0.02),
        child: Container(
          width: kwidth(context, 0.9),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: kbgColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(children: <Widget>[
            const SectionTitle(
              title: "Ma librairie",
            ),
            Container(
                padding:
                    EdgeInsets.only( bottom: 20),
                width: double.infinity,
                height: kheight(context, 0.5),
                decoration: BoxDecoration(
                  color: kbgColor,
                ),
                child: isLoading
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3, childAspectRatio: 0.5),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return const BookItemLoading(
                            small: true,
                            smallest: true,
                          );
                        },
                      )
                    : (books.isEmpty
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
                                    "Aucun livre dans votre bibliothèque",
                                    style: TextStyle(
                                        fontFamily: "Nominee", fontSize: 13),
                                  )
                                ]),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.5),
                            itemCount: books.length,
                            itemBuilder: (context, index) {
                              BookModel book = books[index];
                              return BookItem(
                                book: book,
                                user: widget.user,
                                withNote: true,
                                small: true,
                                smallest: true,
                              );
                            },
                          )))
          ]),
        ));
  }
}
