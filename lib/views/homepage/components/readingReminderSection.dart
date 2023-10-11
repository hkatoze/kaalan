import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/views/globalComponent/bookNumberBox.dart';

class ReadingReminderSection extends StatelessWidget {
  const ReadingReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: kheight(context, 0.01),
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
                      "Remender, Jelly. You have an unfinished book since July 30, 2021",
                      style: TextStyle(
                          fontFamily: "Nominee", color: ksecondaryTextColor),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        "Continue reading",
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
                  width: 20,
                ),
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ther Melian: Discord",
                        style: TextStyle(
                            fontFamily: "Nominee",
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BookNumberBox(
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
