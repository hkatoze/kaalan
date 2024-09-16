import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AuthorItemLoading extends StatefulWidget {
  const AuthorItemLoading({super.key});

  @override
  State<AuthorItemLoading> createState() => _AuthorItemLoadingState();
}

class _AuthorItemLoadingState extends State<AuthorItemLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 224, 224),
        highlightColor: const Color.fromARGB(255, 250, 250, 250),
        enabled: true,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 85,
              color: Colors.white,
              child: Row(children: [
                Container(),
                const Expanded(
                    child: Text(
                  "",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ))
              ]),
            )
          ]),
        ));
  }
}
