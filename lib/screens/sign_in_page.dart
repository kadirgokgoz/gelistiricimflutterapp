import 'package:flutter/material.dart';
import 'package:gelistiricimapp/screens/login_page.dart';

import 'package:gelistiricimapp/widgets/social_log_in_button.dart';
import 'kullanicigiris.dart';



class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.teal],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                )),
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Container(
                margin: EdgeInsets.only(bottom: 90),
                child: Image.asset("assets/gelistiricimmor.png"),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            SocialLoginButton(
              butonText: "Gmail ile Giriş Yapın",
              textColor: Colors.white,
              butonIcon: Image.asset("assets/gmail1.png",
                height: 40,
                width: 40,
              ),
              butonColor: Colors.black26,
              onPressed: () {},
            ),
            SocialLoginButton(
              butonText: "Facebook ile Giriş Yap",
              textColor: Colors.white,
              butonIcon: Image.asset("assets/facebook1.png",
                height: 40,
                width: 40,
                  ),
              onPressed: () {},
              butonColor: Colors.black26,
            ),

            SocialLoginButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder:
                      (context) => LoginPage()),);
              },
              butonText: "Email ve Şifre ile Giriş Yapın",
              textColor: Colors.white,
              butonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 40,
              ),
              butonColor: Colors.black26,
            ),
            SocialLoginButton(
              onPressed: () {},
              butonColor: Colors.black26,
              butonIcon: Icon(Icons.supervised_user_circle,
                  color: Colors.white,
              size: 40
              ),
              butonText: "Misafir Girişi",
            ),

          ],
        ),
      ),
    );
  }
}
