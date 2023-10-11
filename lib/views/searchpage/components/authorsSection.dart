import "package:flutter/material.dart";
import "package:kaalan/testValues.dart";
import "package:kaalan/views/searchpage/components/authorItem.dart";
import "package:kaalan/views/searchpage/components/sectionTitle.dart";

class AuthorsSection extends StatelessWidget {
  const AuthorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: "Top Authors Search",
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: authorsList.length,
              itemBuilder: (context, index) =>
                  AuthorItem(author: authorsList[index])),
        )
      ],
    );
  }
}
