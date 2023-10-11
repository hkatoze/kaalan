import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  List<String> catList = [
    "Education & Formation",
    "African culture & Society",
    "Youth",
    "Religion & Spirituality",
    "Classic novels",
    "Science fiction & fantasy",
    "Mystery & Suspense",
    "Personal development",
    "Sciences",
    "Contemporary literature",
    "Art & culture",
    "Cuisine & gastronomy",
    "Travel & adventure",
    "Poetry",
    "History",
    "Biographies & memoirs",
    "Psychology",
    "Social Sciences"
  ];
  int _catSeledted = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const PageScrollPhysics(),
          itemCount: catList.length,
          controller: null,
          itemBuilder: ((context, index) => InkWell(
                onTap: () {
                  setState(() {
                    _catSeledted = index;
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: _catSeledted == index
                              ? kprimaryColor
                              : ksecondaryColor.withOpacity(0.2)),
                      color: _catSeledted == index ? kprimaryColor : kbgColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          catList[index],
                          style: TextStyle(
                              fontFamily: "Nominee",
                              fontWeight: FontWeight.w300,
                              color: _catSeledted == index
                                  ? const Color.fromARGB(255, 222, 222, 222)
                                  : ksecondaryTextColor),
                          textAlign: TextAlign.center,
                        )
                      ]),
                ),
              ))),
    );
  }
}
