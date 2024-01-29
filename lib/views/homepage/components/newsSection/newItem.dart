import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/newsModel.dart';
import 'package:kaalan/views/newReaderpage/newReaderPage.dart';
import 'package:page_transition/page_transition.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key, required this.newItem});
  final NewsModel newItem;

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  String dateParsed = "";
  @override
  void initState() {
    super.initState();
    parseDate(widget.newItem.publishedAt);
  }

  void parseDate(String dateToParsed) async {
    String dateString = dateToParsed;
    DateTime date = DateTime.parse(dateString);

    await initializeDateFormatting('fr', null);
    var formattedDate = DateFormat('EEEE d MMMM', 'fr').format(date);

    setState(() {
      dateParsed = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: NewReaderPage(
                  newItem: widget.newItem,
                )));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        child: Column(children: [
          Container(
            width: kwidth(context, 0.78),
            height: 230,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.newItem.urlToImage))),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: kwidth(context, 0.78),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.newItem.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15, fontFamily: "Nominee", color: Colors.black),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                dateParsed,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Nominee",
                    color: const Color.fromARGB(255, 212, 212, 212)),
              ),
            ]),
          )
        ]),
      ),
    );
  }
}
