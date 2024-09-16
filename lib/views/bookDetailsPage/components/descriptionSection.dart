import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/homepage/components/bookItem.dart';

class DescriptionSection extends StatefulWidget {
  const DescriptionSection(
      {super.key,
      this.book,
      this.author,
      required this.isBook,
      required this.user});
  final BookModel? book;
  final AuthorWithBookModel? author;
  final bool isBook;
  final UserModel user;

  @override
  State<DescriptionSection> createState() => _DescriptionSectionState();
}

class _DescriptionSectionState extends State<DescriptionSection>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  List<BookModel> books = [];
  final _pageController = PageController();
  bool isExpanded = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    fetchData();
    super.initState();
  }

  void fetchData() {
    if (!widget.isBook) {
      setState(() {
        books = widget.author!.books;
      });
    }
  }

  void navigateTo(int offset) {
    _pageController.animateToPage(offset,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  int textSize() {
    String text = widget.isBook
        ? widget.book!.description
        : widget.author!.author.description;

    double calcul = text.length * 180 / 328;
    
    return (calcul).toInt();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        width: kwidth(context, 0.87),
        child: TabBar(
            controller: tabController,
            labelColor: kprimaryColor,
            indicatorColor: kprimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (index) {
              navigateTo(index);
            },
            labelStyle: const TextStyle(
                fontFamily: "Nominee",
                fontWeight: FontWeight.bold,
                fontSize: 17),
            tabs: [
              Tab(
                text: widget.isBook ? "Description" : "Biographie",
              ),
              Tab(
                text: widget.isBook ? "" : "Livres",
              )
            ]),
      ),
      SizedBox(
        height: kheight(context, 0.03),
      ),
      Container(
        width: kwidth(context, 0.87),
        margin: EdgeInsets.only(bottom: 30),
        height: isExpanded
            ? textSize().toDouble() + 30
            : (widget.isBook ? 180 : 300),
        child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              ExpandText(
                  widget.isBook
                      ? widget.book!.description
                      : widget.author!.author.description,
                  indicatorBuilder: (context, onTap, isExpandedvalue) =>
                      GestureDetector(
                        onTap: () {
                          onTap();

                          setState(() {
                            isExpanded = !isExpandedvalue;
                          });
                        },
                        child: Container(
                            width: 50,
                            height: 20,
                            child: Center(
                              child: Icon(
                              !isExpanded ? Icons.arrow_drop_down: Icons.arrow_drop_up,
                                color: kprimaryColor,
                              ),
                            )),
                      ),
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontFamily: "Nominee"),
                  maxLines: widget.isBook ? 8 : 13,
                  indicatorCollapsedHint: "Show More",
                  indicatorIconColor: kprimaryColor,
                  indicatorExpandedHint: "Show More",
                  capitalizeIndicatorHintText: false,
                  indicatorHintTextStyle: TextStyle(color: kprimaryColor)),
              Container(
                  decoration: const BoxDecoration(),
                  child: books.isEmpty
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
                                  "Aucun livre disponible",
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
                        ))
            ]),
      )
    ]);
  }
}
