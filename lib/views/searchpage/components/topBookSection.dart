import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/testValues.dart';

import 'package:kaalan/views/searchpage/components/horizontalBookItem.dart';
import 'package:kaalan/views/searchpage/components/sectionTitle.dart';

class TopBookSection extends StatelessWidget {
  const TopBookSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: "Top Book Search",
        ),
        SizedBox(
            height: kheight(context, 0.42),
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 1.6,
                  crossAxisSpacing: 20,
                ),
                itemCount: 8,
                itemBuilder: (BuildContext context, index) {
                  return HorizontalBookItem(
                    book: booksList[index],
                  );
                }))
      ],
    );
  }
}
