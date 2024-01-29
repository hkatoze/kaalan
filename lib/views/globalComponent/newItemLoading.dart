import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:shimmer/shimmer.dart';

class NewItemLoading extends StatefulWidget {
  const NewItemLoading({super.key});

  @override
  State<NewItemLoading> createState() => _NewItemLoadingState();
}

class _NewItemLoadingState extends State<NewItemLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Column(children: [
            Container(
              width: kwidth(context, 0.78),
              height: 230,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: kwidth(context, 0.78),
              height: 30,
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Nominee",
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Nominee",
                          color: const Color.fromARGB(255, 212, 212, 212)),
                    ),
                  ]),
            )
          ]),
        ));
  }
}
