import 'package:flutter/material.dart';
import 'package:kaalan/models/userModel.dart';

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
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
              image: AssetImage("assets/logo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.logedUser.lastname} ${widget.logedUser.firstname != null ? widget.logedUser.firstname : ""}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email,
                          color: Colors.white.withOpacity(0.5),
                          size: 15,
                        ),
                        Text(
                          ": ${widget.logedUser.emailAddress}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "Nominee",
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ],
                    )
                  ],
                )
              ]),
        )
      ],
    );
  }
}
