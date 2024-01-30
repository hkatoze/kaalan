import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/userModel.dart';

import 'package:kaalan/views/homepage/homepage.dart';
import 'package:kaalan/views/profilPage/profilPage.dart';

import 'package:kaalan/views/searchpage/searchpage.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key, required this.logedUser});
  final UserModel logedUser;

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int selectedPos = 1;

  late CircularBottomNavigationController _navigationController;
  List<TabItem> tabItems = List.of([
    TabItem(Icons.search, "Recherche", kprimaryColor,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: ksecondaryColor)),
    TabItem(Icons.home, "Accueil", kprimaryColor,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: ksecondaryColor)),
    TabItem(Icons.person, "Profil", kprimaryColor,
        labelStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 13, color: ksecondaryColor)),
  ]);
  void initState() {
    super.initState();
    _navigationController = CircularBottomNavigationController(selectedPos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            child: bodyContainer(),
            padding: EdgeInsets.only(bottom: 60),
          ),
          Align(alignment: Alignment.bottomCenter, child: bottomNav())
        ],
      ),
    );
  }

  Widget bodyContainer() {
    Widget page;
    switch (selectedPos) {
      case 0:
        page = Searchpage(
          user: widget.logedUser,
        );
        break;
      case 1:
        page = Homepage(
          logedUser: widget.logedUser,
        );
        break;
      case 2:
        page = ProfilPage(
          logedUser: widget.logedUser,
        );
        break;

      default:
        page = Container();
        break;
    }

    return GestureDetector(
      child: page,
      onTap: () {},
    );
  }

  Widget bottomNav() {
    return CircularBottomNavigation(
      tabItems,
      controller: _navigationController,
      selectedPos: selectedPos,
      barHeight: 60,
      barBackgroundColor: Colors.white,
      backgroundBoxShadow: <BoxShadow>[
        BoxShadow(color: Colors.black45, blurRadius: 10.0),
      ],
      animationDuration: Duration(milliseconds: 300),
      selectedCallback: (int? selectedPos) {
        setState(() {
          this.selectedPos = selectedPos ?? 0;
          print(_navigationController.value);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _navigationController.dispose();
  }
}
