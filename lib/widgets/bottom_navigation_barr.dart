import "package:flutter/material.dart";

Widget get bottomNavigationBar {

  return ClipRRect(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(30),
      topLeft: Radius.circular(30),
    ),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Colors.white,

      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home), title: Text('Anasayfa')),



        BottomNavigationBarItem(
            icon: Icon(Icons.gamepad), title: Text('Oyun')),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), title: Text('Favorilerim')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profil')),
      ],
      currentIndex: 0,


      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.deepPurple,
      showUnselectedLabels: true,
    ),
  );
}