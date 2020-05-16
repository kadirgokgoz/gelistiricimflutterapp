import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gelistiricimapp/screens/kayitol.dart';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'package:gelistiricimapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

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
  alertGoster(BuildContext context)
  {
    var alert=AlertDialog(title: Text("E-posta gönderildi"),content: Text("Gelen ve spam kutunuzu kontrol ediniz"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.of(context).pop();},)],);
    return showDialog(context: context,builder: (context){ return alert;});
  }
  alertGoster2(BuildContext context)
  {
    var alert=AlertDialog(title: Text("E-posta gönderilemedi!"),content: Text("Hatalı e-posta verisi"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.of(context).pop();},)],);
    return showDialog(context: context,builder: (context){ return alert;});
  }
  forgotPassword(String email) async
  {
    Map eposta = {
      'email': email,

    };
    var jsonResponse = null;
    var response = await http.post("https://gelistiricim.herokuapp.com/api/forgotpassword",body: eposta );
    if(response.statusCode==200)
    {
        alertGoster(context);
    }
    else {
        alertGoster2(context);
    }
  }


  Column buttonSection() {
    return Column(children: <Widget>[

      Container(
        width: MediaQuery.of(context).size.width,
        height: 40.0,

        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        child: RaisedButton(
          onPressed:emailController.text == "" ? null :(){ forgotPassword(emailController.text);},
          elevation: 0.0,
          color: Colors.purple,
          child: Text("E-posta Gönder", style: TextStyle(color: Colors.white70)),
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
              hintText: "E-posta adresi",
              border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
              hintStyle: TextStyle(color: Colors.white70),
            ),
          ),
          SizedBox(height: 30.0),


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