import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:gelistiricimapp/models/article.dart';
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
import 'package:gelistiricimapp/screens/sign_in_page.dart';

class KayitOl extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "yazi",
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.blueGrey[600]
      ),
      home: Scaffold(
        body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [Colors.blue, Colors.teal],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter),
    ),
    child:Register()),)
    );
  }
}

class Register extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return _Register(context);
  }
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
alertGoster(BuildContext context)
{
  var alert=AlertDialog(title: Text("Hatalı veri"),content: Text("Kullanıcı adı veya Şifre Hatalı"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.of(context).pop();},)],);
  return showDialog(context: context,builder: (context){ return alert;});
}
alertGosterBasarili(BuildContext context)
{
  var alert=AlertDialog(title: Text("Kayıt Başarılı"),content: Text("Kayıt Başarıyla Oluşturuldu"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.push(context,
    MaterialPageRoute(builder:
        (context) => SignInPage()),);},)],);
  return showDialog(context: context,builder: (context){ return alert;});
}
Widget _Register(BuildContext context)
{
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController userNameController = new TextEditingController();
  final TextEditingController trypasswordController = new TextEditingController();
  List<Article> postData=[];
  Article article;
  void addData() {
    http.post("https://gelistiricim.herokuapp.com/api/register",headers: {'Content-Type' : 'application/x-www-form-urlencoded'},body:({
      'userName':userNameController.text,
      'password':passwordController.text,
      'email':emailController.text
    }) ).then((response){
      if(response.statusCode!=201)
      {
          alertGoster(context);
      }
      else
        {
          alertGosterBasarili(context);
        }
    });


  }

  final userIDField = TextFormField(
    obscureText: false,
    controller: userNameController,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Kullanıcı Adınızı Oluşturunuz",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );
  final emailIDField = TextFormField(
    obscureText: false,
    controller: emailController,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );
  final passwordField = TextFormField(
    controller: passwordController,
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Parola",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );
  final trypasswordField = TextFormField(
    controller: trypasswordController,
    obscureText: true,
    decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Parola Tekrar",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
    ),
  );

  final registerButton = Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(34.0),
    color: Colors.deepPurpleAccent,
    child: MaterialButton(
      splashColor: Colors.purple[100],
      minWidth: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      onPressed: () {
          addData();

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
  return ListView(
    children: <Widget>[
      headerSection(),
      Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 1,bottom: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/kayitol.png",height: 180,),
            ],
          ),
        ),
      ),
      Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top:5.0,left: 40,right: 40,bottom: 10),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[





                SizedBox(height: 8.0,),
                userIDField,

                SizedBox(height: 8.0),
                emailIDField,

                SizedBox(height: 8.0),
                passwordField,

                SizedBox(height: 8.0),
                trypasswordField,

                SizedBox(height: 15.0),
                registerButton,

                SizedBox(height: 30.0),
                BackButton

              ],
            ),
          ),
        ),
      ),
    ],
  );


}

