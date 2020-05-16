import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gelistiricimapp/screens/quizpage.dart';

class gamehomepage extends StatefulWidget {
  @override
  _gamehomepageState createState() => _gamehomepageState();
}

class _gamehomepageState extends State<gamehomepage> {

  List<String> images = [
    "assets/java.png",
    "assets/pythonimage.png",
    "assets/cpp.png",
  ];

  Widget customcard(String langname, String image) {
      return Padding(
        padding: EdgeInsets.all(
            20.0,
        ),
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => getdata(),
            ));
          },
          child: Material(
            color: Colors.white,
            elevation: 10.0,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(100.0),
                      child: Container(
                        height: 200.0,
                        width: 200.0,
                        child: ClipOval(
                          child: Image(
                              image: AssetImage(
                                image,
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                   Center(
                     child: Text(
                       langname,
                       style: TextStyle(
                         fontSize: 24.0,
                         color: Colors.black,
                         fontFamily: 'yazi',
                         fontWeight: FontWeight.w800,
                       ),
                     ),
                   ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                     /*Text(
                      "etkileşimli yüksek seviyeli bir programlama dilidir.  dayalı basit sözdizimi, dilin öğrenilmesini ve akılda kalmasını kolaylaştırır. ",
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.black,
                        fontFamily: "yazi",
                        fontWeight: FontWeight.w800,
                      ),
                      maxLines: 5,
                      textAlign: TextAlign.justify,
                    ),*/
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }

  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.white70.withAlpha(230),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.deepPurple),
            title: Image(
                image: AssetImage(
                  "assets/gelistiricimmor.png",
                ),
                fit: BoxFit.cover,
                height: 31,
                width: 230),
          ),
        body: ListView(
          children: <Widget>[
            customcard("Python", images[1]),
            customcard("Java",images[0]),
            customcard("C++",images[2]),

          ],
        ),
      ),
    );
  }
}
