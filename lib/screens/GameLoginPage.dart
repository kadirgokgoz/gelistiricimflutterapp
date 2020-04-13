import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(title: 'Login App', home: GameLogin()));
}

class GameLogin extends StatelessWidget {
  const GameLogin({Key key}) : super(key: key);
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
              heightFactor: 1.5,
              child: Material(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: Colors.deepPurple[400],
                child: Container(
                  width: 400,
                  height: 400,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('assets/gelistiricimmor.png',width: 250,height:80,),
                        )),

                    Container(
                      width: 200,
                      height: 80,
                      child: RaisedButton(onPressed: (){},color: Colors.deepPurple,textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100.0))),
                        child: Text('Oyuna Başla',style: TextStyle(
                            fontSize: 23.0,


                        ),),),
                    )
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