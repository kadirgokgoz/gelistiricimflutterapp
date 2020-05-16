import 'package:gelistiricimapp/models/article.dart';

class User{
  String username;
  String image="https://i.ya-webdesign.com/images/avatar-png-1.png";
  String role;
  String email;
  Article article;


  User({this.username,this.role, this.email,this.image,this.article});

}