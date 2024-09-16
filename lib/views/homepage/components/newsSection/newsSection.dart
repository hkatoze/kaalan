import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:kaalan/constants.dart";

import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import "package:kaalan/models/newsModel.dart";
import "package:kaalan/services/apiservices.dart";

import "package:kaalan/views/globalComponent/newItemLoading.dart";
import "package:kaalan/views/homepage/components/newsSection/newItem.dart";
import "package:kaalan/views/searchpage/components/sectionTitle.dart";

class NewsSection extends StatefulWidget {
  const NewsSection({super.key, required this.limit, required this.title});
  final String title;
  final int limit;

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  List<NewsModel> news = [];
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

    List<NewsModel> fetchedNews = await fetchNews();

    try {
      setState(() {
        news = fetchedNews;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != "")
          SectionTitle(
            title: widget.title,
          ),
        Container(
          height: 310,
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) => const NewItemLoading())
              : news.isEmpty
                  ? Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                              "Aucune actualité disponible",
                              style: const TextStyle(
                                  fontFamily: "Nominee", fontSize: 13),
                            )
                          ]),
                    )
                  : FlutterCarousel(
                      options: CarouselOptions(
                        height: 310,
                        autoPlay: true,
                        showIndicator: false,
                        viewportFraction: 0.9,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(milliseconds: 7000),
                        autoPlayCurve: Curves.easeInOut,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        slideIndicator: const CircularSlideIndicator(),
                      ),
                      items: news.map((newItem) {
                        return Builder(
                          builder: (BuildContext context) {
                            return NewItem(
                              newItem: newItem,
                            );
                          },
                        );
                      }).toList(),
                    ),
        )
      ],
    );
  }
}
