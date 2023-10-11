import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class ActionButtonsSection extends StatelessWidget {
  const ActionButtonsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 20,
        left: 20,
        child: Container(
          color: kbgColor,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            InkWell(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: ksecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Icon(
                      Icons.bookmark,
                      color: ksecondaryColor,
                    )),
              ),
            ),
            SizedBox(
                width: kwidth(context, 0.7),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kprimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // <-- Radius
                    ),
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        'Continue Reading',
                        style: TextStyle(
                            fontFamily: "Nominee", fontWeight: FontWeight.bold),
                      )),
                )),
          ]),
        ));
  }
}
