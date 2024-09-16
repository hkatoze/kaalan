import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:shimmer/shimmer.dart';

class BookHorizontalLoadingItem extends StatefulWidget {
  const BookHorizontalLoadingItem();

  @override
  State<BookHorizontalLoadingItem> createState() =>
      _BookHorizontalLoadingItemState();
}

class _BookHorizontalLoadingItemState extends State<BookHorizontalLoadingItem> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: SizedBox(
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Container(
                    color: Colors.white,
                    width: kwidth(context, 0.2),
                    child: const Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Nominee",
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: kwidth(context, 0.2),
                    color: Colors.white,
                    child: Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontFamily: "Nominee",
                          color: ksecondaryTextColor,
                          fontSize: 12),
                    ),
                  )
                ])),
          ]),
        ));
  }
}
