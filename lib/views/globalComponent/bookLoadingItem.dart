import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookItemLoading extends StatefulWidget {
  final bool? small;
  final bool? smallest;

  const BookItemLoading({super.key, this.small, this.smallest});

  @override
  State<BookItemLoading> createState() => _BookItemLoadingState();
}

class _BookItemLoadingState extends State<BookItemLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                  width: widget.small == true ? 140 : 150,
                  height: widget.small == true
                      ? (widget.smallest == true ? 150 : 180)
                      : 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 140,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: const Column(children: [
                    Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Nominee", fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontFamily: "Nominee", color: Colors.white),
                    )
                  ]),
                )
              ],
            )));
  }
}
