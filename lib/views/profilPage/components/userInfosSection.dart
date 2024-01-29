import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:shimmer/shimmer.dart';

class UserInfos extends StatefulWidget {
  const UserInfos({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<UserInfos> createState() => _UserInfosState();
}

class _UserInfosState extends State<UserInfos> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          width: 60,
          height: 60,
          imageUrl: "assets/images/profil.png",
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
            width: 65,
            height: 65,
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
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.logedUser.lastname} ${widget.logedUser.firstname}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(widget.logedUser.phone != "fromGoogle")
                    Text(
                      "📞: ${widget.logedUser.phone}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Nominee",
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.5)),
                    ),
                    Text(
                      "Ⓜ️: ${widget.logedUser.emailAddress}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: "Nominee",
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.5)),
                    ),
                  ],
                )
              ]),
        )
      ],
    );
  }
}
