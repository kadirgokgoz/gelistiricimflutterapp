import 'package:flutter/material.dart';
import 'package:gelistiricimapp/screens/Game.dart';

class resultpage extends StatefulWidget {
  int marks;
  resultpage({Key key , @required this.marks}) : super(key : key);
  @override
  _resultpageState createState() => _resultpageState(marks);
}

class _resultpageState extends State<resultpage> {

  List<String> images = [
    "assets/success.png",
    "assets/good.png",
    "assets/bad.png",
  ];
  String message;
  String image;

  @override
  void initState(){
      if(marks < 20){
        image = images[2];
        message = "Çok Denemelisin...\n" + "Skorunuz  $marks";
      }else if(marks < 35){
        image = images[1];
        message = "Daha İyisini Yapabilirsin...\n" + "Skorunuz  $marks";
      }else{
        image = images[0];
        message = "Çok İyiydiniz...\n" + "Skorunuz  $marks";
      }
      super.initState();
  }

  int marks;
  _resultpageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.deepPurple,
         title: Text(
           "Sonuç"
         ),
       ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Material(
              elevation: 10.0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      child: Container(
                        width: 300.0,
                        height: 300.0,
                        child: ClipRect(
                          child: Image(
                            image: AssetImage(
                              image,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 15.0,
                      ),
                      child: Center(
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: "yazi",
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => gamehomepage(),
                    ));
                  },
                  child: Text(
                    "Devam",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 25.0,
                  ),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo ),
                  splashColor: Colors.indigoAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
