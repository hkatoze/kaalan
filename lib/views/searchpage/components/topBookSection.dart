import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/globalComponent/horizontalBookLoadingItem.dart';
import 'package:kaalan/views/searchpage/components/horizontalBookItem.dart';
import 'package:kaalan/views/searchpage/components/sectionTitle.dart';

class TopBookSection extends StatefulWidget {
  const TopBookSection({super.key, required this.title, required this.user});
  final String title;
  final UserModel user;

  @override
  State<TopBookSection> createState() => _TopBookSectionState();
}

class _TopBookSectionState extends State<TopBookSection> {
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

    List<BookModel> fetchedBooks = await fetchTopBooksSearched(8);

    try {
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: widget.title,
        ),
        SizedBox(
            height: 380,
            child: isLoading
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 1.65,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: 8,
                    itemBuilder: (BuildContext context, index) {
                      return const BookHorizontalLoadingItem();
                    })
                : (books.isEmpty
                    ? Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center ,
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
                                "Aucun livre disponible pour le moment.",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontFamily: "Nominee", fontSize: 13),
                              )
                            ]),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 1.65,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: books.length,
                        itemBuilder: (BuildContext context, index) {
                          return HorizontalBookItem(
                            book: books[index],
                            user: widget.user,
                          );
                        })))
      ],
    );
  }
}
