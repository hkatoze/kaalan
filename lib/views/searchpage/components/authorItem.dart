import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/models/authorModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/authorDetailsPage/authorDetailsPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class AuthorItem extends StatelessWidget {
  final AuthorWithBookModel author;
  final UserModel user;
  final bool big;
  final bool? isSimpleImage;
  const AuthorItem(
      {super.key,
      required this.author,
      required this.big,
      required this.user,
      this.isSimpleImage});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isSimpleImage == true) {
        } else {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: AuthorDetailsPage(
                    author: author,
                    user: user,
                  )));
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          CachedNetworkImage(
            width: big ? 200 : 60,
            height: big ? 200 : 60,
            imageUrl: author.author.profilImg,
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
              width: big ? 200 : 60,
              height: big ? 200 : 60,
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
          SizedBox(
            width: 85,
            child: Text(
              author.author.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  fontFamily: "Nominee",
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          )
        ]),
      ),
    );
  }
}
