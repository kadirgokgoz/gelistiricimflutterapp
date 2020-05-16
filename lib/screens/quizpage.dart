import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gelistiricimapp/screens/resultpage.dart';

class getdata extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/java.json"),
      builder: (context, snapshot){
        List mydata = json.decode(snapshot.data.toString());
        if(mydata == null){
            return Scaffold(
              body: Center(
                child: Text(
                "Bekleyiniz",
                ),
              ),
            );
          }else{
            return quizpage(mydata : mydata);
          }
        },
    );
  }
}

class quizpage extends StatefulWidget {
  var mydata;

  quizpage({Key key, @required this.mydata}) : super(key : key);

  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {

  var mydata;
  _quizpageState(this.mydata);

  Color colortoshow = Colors.deepPurple;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  int timer = 30;
  String showtimer = "30";



  Map<String, Color> btncolor = {
    "a" : Colors.deepPurple,
    "b" : Colors.deepPurple,
    "c" : Colors.deepPurple,
    "d" : Colors.deepPurple,
  };

  bool canceltimer = false;

  @override
  void initState(){
    starttimer();
    super.initState();
  }


  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1){
          t.cancel();
          nextquestion();
        }else if(canceltimer == true){
          t.cancel();
        }
        else{
          timer = timer -1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion(){
    canceltimer = false;
    timer = 30;
    setState(() {
      if(i < 10){
        i++;
      }else{

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks : marks),
        ));
      }
      btncolor["a"] = Colors.deepPurple;
      btncolor["b"] = Colors.deepPurple;
      btncolor["c"] = Colors.deepPurple;
      btncolor["d"] = Colors.deepPurple;
    });
    starttimer();
  }

  void checkanswer(String k){
      if(mydata[2]["1"] == mydata[1]["1"][k]){
          marks = marks + 10;
          colortoshow = right;

      }else{
        colortoshow = wrong;
      }
      setState(() {
        btncolor[k] = colortoshow;
        canceltimer = true;
      });

      Timer(Duration(milliseconds: 500), nextquestion);
  }

  Widget choicebutton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Container(
          padding: EdgeInsets.only(top: 7.0, bottom: 7.0),
          child: Text(
            mydata[1][i.toString()][k],
            style: TextStyle(
              color:Colors.white,
              fontFamily: 'yazi',
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
          ),
        ),
        color: btncolor[k] ,
        splashColor: Colors.indigo[800],
        highlightColor: Colors.indigo[800],
        minWidth: MediaQuery.of(context).size.width,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
            builder:(context) => AlertDialog(
              title: Text(
                "Gelistiricim",
              ),
              content: Text(
                "Bu Aşamadan Geri Dönemezsiniz."
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Tamam',
                  ),
                )
              ],
            )
        );
      },
      child: Scaffold(
        body:Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "-Soru  " + i.toString() + " -\n \n" + mydata[0][i.toString()],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: "yazi",
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    choicebutton('a'),
                    choicebutton('b'),
                    choicebutton('c'),
                    choicebutton('d'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(

                    "Kalan Süre : "+showtimer,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'yazi',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

