

import 'package:flutter/material.dart';
import 'package:gelistiricimapp/main.dart';
import 'package:gelistiricimapp/models/article.dart';
import 'package:gelistiricimapp/models/user.dart';
import 'package:gelistiricimapp/screens/articles_page.dart';
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import"dart:io";
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';

import 'article_single_page.dart';

// ignore: must_be_immutable
class OtherUserProfilePage extends StatefulWidget {
  String username;

  OtherUserProfilePage({this.username});

  @override
  _OtherUserProfilePageState createState() => _OtherUserProfilePageState();
}

class _OtherUserProfilePageState extends State<OtherUserProfilePage> {
  String fullName = "Hasancan İsbeceren";

  String status = "Software Developer";

  String bio =
      " Microsoft’un kurucusu Bill Gates, 1955 yılında dünyaya geldi. Zengin bir ailenin çocuğu olarak Seattle’da doğan Gates, elindeki kaynakları doğru şekilde kullanmayı başararak bugün dünyanın sayılı zenginlerinden biri oldu. Şans, vizyon ve çok çalışmanın bir eseri olan başarı hikayesiyle “her eve bir bilgisayar sokabilmek” vizyonunu dünyaya getiren bu ünlü kişi, 1975 yılında Microsoft’u kurdu ve kısa zaman içinde dünyanın sayılı multimilyarderlerinden biri haline geldi.";

  String followers = "173";

  String posts = "24";

  String scores = "450";

  List<User> userData = [];
  User user;
  Article article;
  String image;
  List<Article> postData=[];
  String postContent;
  String postImage;
  Future<List<Article>> getPosts() async {
    var data = await http.get("https://gelistiricim.herokuapp.com/api/profile/"+widget.username);
    var jsondata = json.decode(data.body);
    var veri = jsondata["data"]["user_posts"];
    //print(veri);
    var username;
    String name;

    for (int i=0; i<5;i++) {


      article = Article(
          title: veri[i]["title"],
          content: veri[i]["slug"],
        image: veri[i]["image_url"]

      );

      postData.add(article);

    }

    return postData;
  }


  Future<User> getUser() async {
    //getPosts();
    //print(widget.username);
    var data = await http.get("https://gelistiricim.herokuapp.com/api/profile/"+widget.username);
    var jsondata = json.decode(data.body);

    var veri = jsondata["data"]["user_data"];
    //print(veri);
    var postveri = jsondata["data"]["user_posts"];
    //print(postveri);

    /*for(int i=0; i<5 ; i++) {
      String degisken=postveri[i]["title"];
      print(degisken);
      postTitle.add(degisken);

    }*/
  //print(postTitle);




    user = User(username: veri["username"],email: veri["email"],image: veri["images"]);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    //checkLoginStatus();


    return Scaffold(
      appBar: new AppBar(

        leading:FlatButton(
          onPressed: () {
            Navigator.of(context).pop();

          },
          child: Icon(Icons.arrow_back,color: Colors.deepPurple,
          ),
        ),

        title: Image(
            image: AssetImage(
              "assets/gelistiricimmor.png",
            ),
            fit: BoxFit.cover,
            height: 31,
            width: 230),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.deepPurple),

      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[

            _buildCoverImage(screenSize),
            SafeArea(
              child: FutureBuilder(
                  future: getUser(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: Text("yükleniyor..."),
                        ),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics:
                          ScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: 1,
                          itemBuilder: (context, index) {

                            return Column(
                              children: <Widget>[
                                SizedBox(height: screenSize.height / 6.4),
                                _buildProfileImage(snapshot.data.image),
                                _buildFullName(snapshot.data.username),
                                _buildStatus(context,snapshot.data.email),




                                //    _buildSeparator(screenSize),
                                //    _buildGetInTouch(context),
                                SizedBox(height: 6.0),
                                Text(
                                  "Paylaşımlar",
                                  style: TextStyle(
                                      fontFamily: 'yazi',
                                      color: Colors.black,
                                      fontSize: 28.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(height: 10.0),
                                _buildArticle(),
                              ],
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://steamcommunity-a.akamaihd.net/economy/image/-9a81dlWLwJ2UUGcVs_nsVtzdOEdtWwKGZZLQHTxH5rd9eDAjcFyv45SRYAFMIcKL_PArgVSL403ulRUWEndVKv7gpeGBg07J1UFsOujLQE41aHLJ2hGud_uwtGNkfH2Zb3TlWlTsJR32LrF9N_x0Bq-uxQYVYse3w'),
            fit: BoxFit.cover,
          )),
    );
  }


  Widget _buildProfileImage(String image) {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image=="none"?"https://i.ya-webdesign.com/images/avatar-png-1.png":"https://gelistiricim.herokuapp.com/uploads/"+image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 10.0,
          ),

        ),

      ),
    );
  }

  Widget _buildFullName(String fullname) {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'yazi',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      fullname,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context, String stat) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        stat,
        style: TextStyle(
          fontFamily: 'yazi',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'yazi',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          _buildStatItem("Makale Sayısı", posts),

        ],
      ),
    );
  }



  Widget _buildSeparator(Size screenSize) {
    return Center(
      child: Container(
        width: screenSize.width / 1.6,
        height: 2.0,
        color: Colors.black12,
        margin: EdgeInsets.only(top: 4.0),
      ),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with ${fullName.split(" ")[0]},",
        style: TextStyle(fontFamily: 'yazi', fontSize: 16.0),
      ),
    );
  }

  Widget _buildArticle() {
    return SingleChildScrollView(
        child: FutureBuilder(
            future: getPosts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("yükleniyor..."),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleSinglePage(article: snapshot.data[index],)));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
                            alignment: Alignment.center,
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(100, 10, 20, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        width: 200,
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  //Text(postData[index].content),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 15,
                          bottom: 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image(
                              width: 100,
                              image: NetworkImage(
                                snapshot.data[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        _buildSeparator(Size(500, 2)),
                      ],
                    );
                  },
                );
              }
            }));
  }




}
