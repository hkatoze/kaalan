import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/bookDetailsPage/bookDetailsPage.dart';
import 'package:kaalan/views/globalComponent/bookMetadataItem.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class BookItem extends StatelessWidget {
  final BookModel book;
  final UserModel user;
  final bool withNote;
  final bool? small;
  final bool? smallest;
  final bool? isSimpleImage;

  const BookItem(
      {super.key,
      required this.book,
      required this.withNote,
      required this.user,
      this.small,
      this.smallest,
      this.isSimpleImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSimpleImage == true) {
        } else {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  child: BookDetailsPage(
                    book: book,
                    user: user,
                  )));
        }
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              CachedNetworkImage(
                  width: small == true ? 140 : 150,
                  height: small == true ? (smallest == true ? 150 : 180) : 220,
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
                                  child: const BookMetadataItem(
                                    unit: "/5 ",
                                    value: "3",
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
          )),
    );
  }
}
