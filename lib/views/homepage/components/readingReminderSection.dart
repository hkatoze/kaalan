import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/views/globalComponent/bookNumberBox.dart';

class ReadingReminderSection extends StatelessWidget {
  const ReadingReminderSection({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 10,
        right: kwidth(context, 0.07),
        left: kwidth(context, 0.07),
        child: Container(
          width: kwidth(context, 0.9),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(children: <Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color(0xFFF7F9FD),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rappel: ${logedUser.lastname} ,vous avez un livre inachevé depuis le 30 juillet 2021.",
                      style: TextStyle(
                          fontFamily: "Nominee", color: ksecondaryTextColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Continuez à lire",
                        style: TextStyle(
                            color: ksecondaryColor,
                            fontFamily: "Nominee",
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ]),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/book-img.jpg")),
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  width: 17,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  SizedBox(
                    width: kwidth(context, 0.45),
                    child: const Text(
                      "Ther Melian: Discord",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: "Nominee",
                          fontWeight: FontWeight.bold,
                          
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const BookNumberBox(
                    number: 3,
                    total: 4,
                  )
                ]),
              ]),
            )
          ]),
        ));
  }
}
