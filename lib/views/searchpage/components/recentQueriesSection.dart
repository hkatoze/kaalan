import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/searchQueryModel.dart';
import 'package:kaalan/services/localdbservices.dart';

class RecentQueriesSection extends StatefulWidget {
  RecentQueriesSection({Key? key, required this.searchController})
      : super(key: key);
  final TextEditingController searchController;

  @override
  State<RecentQueriesSection> createState() => _RecentQueriesSectionState();
}

class _RecentQueriesSectionState extends State<RecentQueriesSection> {
  List<SearchQueryModel> recentQueries = [];

  @override
  void initState() {
    super.initState();
    fetchQueries();
    widget.searchController.addListener(fetchQueries);
  }

  void fetchQueries() async {
    final List<SearchQueryModel> queries =
        await DatabaseManager.instance.getQueries();
    setState(() {
      recentQueries = queries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: kheight(context, 0.03)),
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
                onPressed: () async {
                  await DatabaseManager.instance.deleteAllQueries();
                  setState(() {
                    recentQueries.clear();
                  });
                },
                child: const Text(
                  "Supprimer tout",
                  style: TextStyle(
                      fontFamily: "Nominee", fontSize: 14, color: Colors.grey),
                ))
          ]),
        ),
        Wrap(
          spacing: kwidth(context, 0.016),
          runSpacing: kheight(context, 0.02),
          children: List<Widget>.generate(recentQueries.reversed.length, (int index) {
            return GestureDetector(
              onTap: () {
                widget.searchController.text = recentQueries[index].query;
              },
              child: Chip(
                backgroundColor: const Color.fromARGB(255, 241, 245, 253),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(14),
                deleteIcon: const Icon(
                  Icons.close,
                  size: 19,
                ),
                label: Text(
                  recentQueries[index].query,
                  style: const TextStyle(fontFamily: "Nominee", fontSize: 13),
                ),
                onDeleted: () async {
                  await DatabaseManager.instance
                      .deleteQuery(recentQueries[index].id!);
                  setState(() {
                    recentQueries.removeAt(index);
                  });
                },
              ),
            );
          }),
        )
      ],
    );
  }
}
