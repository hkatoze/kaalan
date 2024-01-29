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
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbgColor,
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children: <Widget>[
            Homepage(
              logedUser: widget.logedUser,
            ),
            Container(),
            Searchpage(
              user: widget.logedUser,
            ),
            ProfilPage(
              logedUser: widget.logedUser,
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: kprimaryTextColor,
        unselectedItemColor: ksecondaryTextColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Acueil'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Notes'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Recherche'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _pageController.jumpToPage(
      index,
    );
  }
}
