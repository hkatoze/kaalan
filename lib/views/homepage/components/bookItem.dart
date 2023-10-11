import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/views/globalComponent/bookMetadataItem.dart';
import 'package:shimmer/shimmer.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  final bool withNote;
  const BookItem({super.key, required this.book, required this.withNote});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            CachedNetworkImage(
                width: 150,
                height: 220,
                imageUrl: book.cover,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          if (withNote)
                            Container(
                                margin:
                                    const EdgeInsets.only(left: 10, top: 10),
                                padding: const EdgeInsets.all(1),
                                width: 65,
                                height: 23,
                                decoration: BoxDecoration(
                                    color: kbgColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: BookMetadataItem(
                                  unit: "/5 ",
                                  value: "${book.apreciationStar}",
                                  withIcon: true,
                                  icon: Icons.star,
                                ))
                        ],
                      ),
                    ),
                placeholder: (context, url) => SizedBox(
                      width: 70,
                      height: 70,
                      child: Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 226, 224, 224),
                        highlightColor:
                            const Color.fromARGB(255, 250, 250, 250),
                        child: const Text(
                          '',
                        ),
                      ),
                    ),
                errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 250, 249, 249),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.error,
                        color: Color.fromARGB(255, 210, 206, 206),
                      ),
                    )),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 140,
              child: Column(children: [
                Text(
                  book.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Nominee", fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  book.author,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee", color: ksecondaryTextColor),
                )
              ]),
            )
          ],
        ));
  }
}
