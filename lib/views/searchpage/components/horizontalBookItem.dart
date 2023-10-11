import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalBookItem extends StatelessWidget {
  final BookModel book;
  const HorizontalBookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
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
                  Text(
                    book.author,
                    style: TextStyle(
                        fontFamily: "Nominee",
                        color: ksecondaryTextColor,
                        fontSize: 12),
                  )
                ])),
          ]),
        ));
  }
}
