
import 'package:flutter/material.dart';
import 'package:gelistiricimapp/screens/GameLoginPage.dart';
import 'package:gelistiricimapp/screens/My_Profile.dart';
import 'package:gelistiricimapp/mainPage.dart';
import 'package:gelistiricimapp/screens/MyFavorites.dart';

class bottomNavigationBar extends StatefulWidget {
  @override
  _BottomNavigationBarControllerState createState() =>
      _BottomNavigationBarControllerState();
}

class _BottomNavigationBarControllerState
    extends State<bottomNavigationBar> {
  final List<Widget> pages = [
    MyApp(
      key: PageStorageKey('Anasayfa'),
    ),
    MyFavorites(
      key: PageStorageKey('Favorilerim'),
    ),
    GameLogin(
      key: PageStorageKey('Oyun'),
    ),
    UserProfile(
      key: PageStorageKey('Profilim'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  int _selectedIndex = 0;

  Widget _bottomNavigationBar(int selectedIndex) => BottomNavigationBar(
    onTap: (int index) => setState(() => _selectedIndex = index),
    currentIndex: selectedIndex,
    type: BottomNavigationBarType.fixed,
    elevation: 0,

    backgroundColor: Colors.white,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(Icons.home), title: Text('Anasayfa')),
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border), title: Text('Favorilerim')),
      BottomNavigationBarItem(
          icon: Icon(Icons.gamepad), title: Text('Oyun')),
      BottomNavigationBarItem(
          icon: Icon(Icons.person), title: Text('Profilim')),
    ],
    unselectedItemColor: Colors.black,
    selectedItemColor: Colors.deepPurple,
    showUnselectedLabels: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(_selectedIndex),
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
    );
  }
}
