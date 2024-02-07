import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/globalComponent/bookLoadingItem.dart';
import 'package:kaalan/views/homepage/components/bookItem.dart';

class BookListSection extends StatefulWidget {
  const BookListSection({Key? key, required this.category, required this.user})
      : super(key: key);
  final String category;
  final UserModel user;

  @override
  State<BookListSection> createState() => _BookListSectionState();
}

class _BookListSectionState extends State<BookListSection> {
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

    List<BookModel> fetchedBooks = widget.category != "Tout"
        ? await fetchBooksByCategories(widget.category)
        : await fetchAllBooks();

    try {
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
      height: 290,
      child: isLoading
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(),
              itemCount: 6,
              itemBuilder: ((context, index) {
                return const BookItemLoading();
              }))
          : books.isEmpty
              ? Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: SvgPicture.asset(
                            "assets/svg/empty.svg",
                            semanticsLabel: 'Acme Logo',
                            height: 80,
                          ),
                        ),
                        SizedBox(
                          height: kheight(context, 0.03),
                        ),
                        Text(
                          "Aucun livre disponible pour ${widget.category}.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: "Nominee", fontSize: 13),
                        )
                      ]),
                )
              : FlutterCarousel(
                  options: CarouselOptions(
                    height: 310,
                    autoPlay: true,
                    viewportFraction: 0.45,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(milliseconds: 5000),
                    autoPlayCurve: Curves.easeInOut,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    showIndicator: false,
                    slideIndicator: const CircularSlideIndicator(),
                  ),
                  items: books.map((bookItem) {
                    return Builder(
                      builder: (BuildContext context) {
                        return BookItem(
                          book: bookItem,
                          user: widget.user,
                          withNote: true,
                        );
                      },
                    );
                  }).toList(),
                ),
    );
  }
}
