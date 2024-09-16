import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CategoryItemLoading extends StatefulWidget {
  const CategoryItemLoading({super.key});

  @override
  State<CategoryItemLoading> createState() => _CategoryItemLoadingState();
}

class _CategoryItemLoadingState extends State<CategoryItemLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "",
              style: TextStyle(
                fontFamily: "Nominee",
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            )
          ]),
        ));
  }
}
