import 'dart:ffi';
import 'package:gelistiricimapp/main.dart';
import 'package:gelistiricimapp/screens/kayitol.dart';
import 'package:gelistiricimapp/screens/sign_in_page.dart';
import 'package:flutter/material.dart';



class KullaniciGiris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "yazi",
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.white
      ),
      home: Scaffold(
          appBar: AppBar(title: Center(
            child: Text("Giriş Yap",
              style: TextStyle(
                fontSize: 20.0,
                color:Colors.white,

              ),
            ),
          ),
          ),
          body: LoginHome()
      ),
    );
  }
}

class LoginHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _LoginHome(context);
  }
}

Widget _LoginHome(BuildContext context)
{
  final emailField = TextField(
    obscureText: false,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Kullanıcı Adı/ Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );

  final passwordField = TextField(
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Parola",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );

  final loginButton = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(34.0),
    color: Colors.deepPurple[300],
    child: MaterialButton(
      splashColor: Colors.purple[100],
      minWidth: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder:
              (context) => MyApp()
          ),
        );

      },

      child: Text("Giriş Yap",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),
      ),
    ),
  );

  final registerButton = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(34.0),
    color: Colors.black54,
    child: MaterialButton(
      splashColor: Colors.purple[100],
      minWidth: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder:
              (context) => KayitOl()),);

      },

      child: Text("Kayıt Ol",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),
      ),
    ),
  );
  final BackButton = Material(

    elevation: 0.0,
    borderRadius: BorderRadius.circular(34.0),
    color: Colors.blueGrey[100],
    child: MaterialButton(
      splashColor: Colors.purple[100],
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
        Navigator.push(context,
          MaterialPageRoute(builder:
              (context) => SignInPage()),);
      },
      child: Text("Giriş Sayfasına Dön",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black87,fontStyle: FontStyle.normal),
      ),
    ),
  );
  return Center(
    child: Container(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/image.png",height: 180,),


            SizedBox(height: 8.0,),
            emailField,

            SizedBox(height: 8.0),
            passwordField,

            SizedBox(height: 25.0),
            loginButton,

            SizedBox(height: 8.0),
            registerButton,

            SizedBox(height: 35.0),
            BackButton
          ],
        ),
      ),
    ),
  );


}

