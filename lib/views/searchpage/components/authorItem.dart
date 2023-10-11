import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:shimmer/shimmer.dart';

class AuthorItem extends StatelessWidget {
  final AuthorModel author;
  const AuthorItem({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          CachedNetworkImage(
            width: 60,
            height: 60,
            imageUrl: author.profilImg,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => SizedBox(
              width: 60,
              height: 60,
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
            height: 5,
          ),
          Text(
            author.name,
            style: const TextStyle(
                fontFamily: "Nominee",
                fontSize: 13,
                fontWeight: FontWeight.bold),
          )
        ]),
      ),
    );
  }
}
