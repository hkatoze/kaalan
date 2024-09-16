import 'package:flutter/material.dart';

import 'package:kaalan/models/bookFromLibraryModel.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/services/localdbservices.dart';
import 'package:kaalan/views/profilPage/components/editBtn.dart';

class StatsInfos extends StatefulWidget {
  const StatsInfos({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<StatsInfos> createState() => _StatsInfosState();
}

class _StatsInfosState extends State<StatsInfos> {
  int bookLength = 0;
  int finishedBookLength = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    List<BookModel> fetchedBooks = await fetchLibraryBooks(widget.logedUser.id);
    List<BookFromLibraryModel> finichedBooks =
        await DatabaseManager.instance.getFinishedBooks();

    try {
      setState(() {
        bookLength = fetchedBooks.length;
        finishedBookLength = finichedBooks.length;
        isLoading = false;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    double minWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${isLoading ? '0' : bookLength}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  "Livres ajoutés",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${isLoading ? '0' : finishedBookLength}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                Text(
                  "Livres terminés",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "Nominee",
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.5)),
                ),
              ]),
          if (minWidth >= 420) const EditBtn()
        ],
      ),
    );
  }
}
