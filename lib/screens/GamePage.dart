import 'package:flutter/material.dart';
import 'package:gelistiricimapp/screens//Game.dart';
import 'dart:async';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key key}) : super(key: key);
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => gamehomepage(),
        ));
      });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.deepPurple[200],
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              widthFactor: 0.6,
              heightFactor: 1.3,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.deepPurple[400],
                child: Container(
                  width: 400,
                  height: 800,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.asset('assets/gelistiricimmor.png',width: 300,height:80,),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}