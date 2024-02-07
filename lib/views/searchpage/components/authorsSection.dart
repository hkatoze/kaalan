import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:kaalan/constants.dart";
import "package:kaalan/models/authorModel.dart";
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import "package:kaalan/models/userModel.dart";
import "package:kaalan/services/apiservices.dart";
import "package:kaalan/views/globalComponent/authorItemLoading.dart";

import "package:kaalan/views/searchpage/components/authorItem.dart";
import "package:kaalan/views/searchpage/components/sectionTitle.dart";

class AuthorsSection extends StatefulWidget {
  const AuthorsSection(
      {super.key,
      required this.limit,
      required this.title,
      required this.user});
  final String title;
  final int limit;
  final UserModel user;

  @override
  State<AuthorsSection> createState() => _AuthorsSectionState();
}

class _AuthorsSectionState extends State<AuthorsSection> {
  List<AuthorWithBookModel> authors = [];
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

    List<AuthorWithBookModel> fetchedAuthors =
        await fetchTopAuthorsSearched(widget.limit);

    try {
      setState(() {
        authors = fetchedAuthors;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.title != "")
          SectionTitle(
            title: widget.title,
          ),
        SizedBox(
          height: 110,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => const AuthorItemLoading())
              : (authors.isEmpty
                  ? Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: SvgPicture.asset(
                                "assets/svg/empty.svg",
                                semanticsLabel: 'Acme Logo',
                                height: 60,
                              ),
                            ),
                            SizedBox(
                              height: kheight(context, 0.03),
                            ),
                            Text(
                              "Aucun auteur disponible pour le moment.",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: "Nominee", fontSize: 13),
                            )
                          ]),
                    )
                  : FlutterCarousel(
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        viewportFraction: 0.3,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(milliseconds: 5000),
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        showIndicator: false,
                        slideIndicator: const CircularSlideIndicator(),
                      ),
                      items: authors.map((author) {
                        return Builder(
                          builder: (BuildContext context) {
                            return AuthorItem(
                              author: author,
                              big: false,
                              user: widget.user,
                            );
                          },
                        );
                      }).toList(),
                    )),
        )
      ],
    );
  }
}
