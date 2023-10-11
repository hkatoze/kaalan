import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class RecentQueriesSection extends StatefulWidget {
  const RecentQueriesSection({super.key});

  @override
  State<RecentQueriesSection> createState() => _RecentQueriesSectionState();
}

class _RecentQueriesSectionState extends State<RecentQueriesSection> {
  List<String> recentQueries = [
    "TM Academy",
    "J.K Rowling",
    "Mystique",
    "Marmut Merah Jambu",
    "The Lord of The Rings",
    "The Smurf"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: kheight(context, 0.03)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text(
              "Recent",
              style: TextStyle(
                  fontFamily: "Nominee",
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    recentQueries.clear();
                  });
                },
                child: const Text(
                  "Clear all",
                  style: TextStyle(
                      fontFamily: "Nominee", fontSize: 14, color: Colors.grey),
                ))
          ]),
        ),
        Wrap(
          spacing: kwidth(context, 0.016),
          runSpacing: kheight(context, 0.02),
          children: List<Widget>.generate(recentQueries.length, (int index) {
            return Chip(
              backgroundColor: const Color.fromARGB(255, 241, 245, 253),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(14),
              deleteIcon: const Icon(
                Icons.close,
                size: 19,
              ),
              label: Text(
                recentQueries[index],
                style: const TextStyle(fontFamily: "Nominee", fontSize: 13),
              ),
              onDeleted: () {
                setState(() {
                  recentQueries.removeAt(index);
                });
              },
            );
          }),
        )
      ],
    );
  }
}
