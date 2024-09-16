import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kaalan/constants.dart';

import 'package:kaalan/models/categoryModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/views/globalComponent/categoryItemLoading.dart';
import 'package:kaalan/views/homepage/components/bookListSection.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key, required this.user});
  final UserModel user;

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int _catSeledted = 0;
  bool isLoading = false;
  List<CategoryModel> categories = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    List<CategoryModel> fetchedCategories = await fetchCategories();
    try {
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {}

    if (categories.isNotEmpty) {
      fetchBooks(categories[_catSeledted].name);
    }
  }

  Future<void> fetchBooks(String category) async {
    await fetchBooksByCategories(category);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: isLoading
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const PageScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: ((context, index) {
                    return const CategoryItemLoading();
                  }))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: ((context, index) {
                    CategoryModel category = categories[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _catSeledted = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: _catSeledted == index
                                    ? kprimaryColor
                                    : ksecondaryColor.withOpacity(0.2)),
                            color: _catSeledted == index
                                ? kprimaryColor
                                : kbgColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 246, 240, 240),
                                    borderRadius: BorderRadius.circular(5)),
                                child: category.icon == ""
                                    ? SvgPicture.asset(
                                        "assets/svg/logo.svg",
                                        semanticsLabel: 'Acme Logo',
                                        height: 30,
                                        width: 30,
                                      )
                                    : SvgPicture.network(
                                        category.icon,
                                        semanticsLabel: 'Acme Logo',
                                        height: 30,
                                        width: 30,
                                        color: kprimaryColor,
                                      ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                category.name,
                                style: TextStyle(
                                    fontFamily: "Nominee",
                                    fontWeight: FontWeight.w300,
                                    color: _catSeledted == index
                                        ? Color.fromARGB(255, 116, 96, 96)
                                        : ksecondaryTextColor),
                                textAlign: TextAlign.center,
                              )
                            ]),
                      ),
                    );
                  })),
        ),
        if (categories.isNotEmpty)
          BookListSection(
            category: categories[_catSeledted].name, user: widget.user,
            key:
                UniqueKey(), // Ajoutez cette ligne pour reconstruire le widget BookListSection avec une nouvelle clé unique
          )
      ],
    );
  }
}
