import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewItemLoading extends StatelessWidget {
  const NewItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: 280,
        ));
  }
}
