import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gelistiricimapp/screens/kayitol.dart';
import 'package:http/http.dart' as http;
import 'package:gelistiricimapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.teal],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
             Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 1,bottom: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/image.png",height: 180,),
                    ],
                  ),
                ),
              ),
            textSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }
  signIn(String userName, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'userName': userName,
      'password': pass
    };
    var jsonResponse = null;
    var response = await http.post("https://gelistiricim.herokuapp.com/api/login", body: data);
    if(response.statusCode == 200) {
      jsonResponse = json.decode(response.body);

      if(jsonResponse != null) {
          setState(() {
            _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MyApp()), (Route<dynamic> route) => false);
      }
    }
    else {
      print(response.body);
      setState(() {
        _isLoading = false;
      });
      alertGoster(context);
    }
  }
  alertGoster(BuildContext context)
  {
    var alert=AlertDialog(title: Text("Hatalı veri"),content: Text("Kullanıcı adı veya Şifre Hatalı"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.of(context).pop();},)],);
    return showDialog(context: context,builder: (context){ return alert;});
  }
  Column buttonSection() {
    return Column(children: <Widget>[
      Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        child: RaisedButton(
          onPressed: emailController.text == "" || passwordController.text == "" ? null : () {
            setState(() {
              _isLoading = true;
            });
            signIn(emailController.text, passwordController.text);
          },
          elevation: 0.0,
          color: Colors.purple,
          child: Text("Giriş Yap", style: TextStyle(color: Colors.white70)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        child: RaisedButton(
          onPressed:()=> Navigator.push(context,
            MaterialPageRoute(builder:
                (context) => KayitOl()),),
          elevation: 0.0,
          color: Colors.purple,
          child: Text("Kayıt Ol", style: TextStyle(color: Colors.white70)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
    ],);
  }
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.white70),
              hintText: "Kullanıcı adı",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.white70),
              hintText: "Şifre",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
  Container headerSection() {
    return Container(
      width: 100,
      height: 55,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Image.asset("assets/gelistiricimmor.png"),
        ),
      ),
    );
  }
}