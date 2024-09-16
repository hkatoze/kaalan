import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/bookDetailsPage/bookDetailsPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalBookItem extends StatelessWidget {
  final BookModel book;
  final UserModel user;
  const HorizontalBookItem({super.key, required this.book, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: BookDetailsPage(
                    book: book,
                    user: user,
                  )));
        },
        child: SizedBox(
          width: double.infinity,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CachedNetworkImage(
              width: 70,
              height: 70,
              imageUrl: book.cover,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => SizedBox(
                width: 70,
                height: 70,
                child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 226, 224, 224),
                  highlightColor: const Color.fromARGB(255, 250, 250, 250),
                  child: const Text(
                    '',
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    book.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: "Nominee",
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: kwidth(context, 0.2),
                    child: Text(
                      book.author,
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
