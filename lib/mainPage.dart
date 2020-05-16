import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gelistiricimapp/models/education.dart';
import 'package:gelistiricimapp/screens/My_Profile.dart';
import 'package:gelistiricimapp/main.dart';
import 'package:gelistiricimapp/screens/MyFavorites.dart';
import 'package:gelistiricimapp/screens/Profile.dart';
import 'package:gelistiricimapp/screens/articles_page.dart';
import 'package:gelistiricimapp/screens/createArticle.dart';
import 'package:gelistiricimapp/screens/education_page.dart';
import 'package:gelistiricimapp/screens/education_single_page.dart';
import 'package:gelistiricimapp/screens/sign_in_page.dart';
import 'data.dart';
import 'educationdata.dart';
import 'models/article.dart';
import 'models/user.dart';
import 'screens/article_single_page.dart';
import "package:gelistiricimapp/widgets/bottom_navigation_bar.dart";
import "widgets/card_scroll_widget.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
import 'package:gelistiricimapp/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MaterialApp(
    theme:
        ThemeData(primarySwatch: Colors.deepPurple, accentColor: Colors.purple),
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  //Article articles;
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences sharedPreferences;

  void initState() {
    getPosts();
    super.initState();
    checkLoginStatus();
    getUser();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
          (Route<dynamic> route) => false);
    }
  }

  List<Article> postData = [];
  Article article;

  Future<List<Article>> getPosts() async {
    var data = await http.get("https://gelistiricim.herokuapp.com/api/post");
    var jsondata = json.decode(data.body);
    var veri = jsondata["data"];
    var username;
    String name;
    for (var post in veri) {


      article = Article(
          title: post["title"],
          content: post["content"],
          image: post["image_url"],
          userName: post["author"]["userName"]
      );

      postData.add(article);
    }

    return postData;
  }

  List<Education> eduData = [];
  Education education;

  Future<List<Education>> getEdus() async {
    var data =
        await http.get("https://gelistiricim.herokuapp.com/api/education");
    var jsondata = json.decode(data.body);
    var gelenVeri = jsondata["data"];
    for (var post in gelenVeri) {
      education = Education(
          id: post["_id"],
          title: post["title"],
          content: post["description"],
          image: post["image"]);
      eduData.add(education);
    }

    return eduData;
  }

  List<User> userData = [];
  User user;
  String username;
  String email;

  Future<User> getUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    var data = await http.get("https://gelistiricim.herokuapp.com/api/profile",
        headers: {'x-access-token': token});
    var jsondata = json.decode(data.body);
    var veri = jsondata["data"];

    user = User(
        username: veri["userName"], role: veri["role"], email: veri["email"],image: veri["images"]);
    username = veri["userName"];
    email = veri["email"];
    userData.add(user);


    return user;
  }

  var currentPage = articles.length - 1.0;
  var educationItem = Padding(
    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
  );

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: articles.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Colors.white,
            Colors.white70.withAlpha(230),
          ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
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
          actions: <Widget>[
            /*FlatButton(
              onPressed: () {
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
              },
              child: Row(children: <Widget>[
                Text("Çıkış",style: TextStyle(color: Colors.deepPurple,fontSize: 16),),
                SizedBox(width: 5,),
                Icon(FontAwesomeIcons.signOutAlt,color:Colors.deepPurple,)
              ],),

            ),*/
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              FutureBuilder(
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
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return UserAccountsDrawerHeader(
                            accountName: Text(snapshot.data.username),
                            accountEmail: Text(snapshot.data.email),
                            currentAccountPicture: CircleAvatar(
                              backgroundImage: NetworkImage(snapshot.data.image=="none"?"https://i.ya-webdesign.com/images/avatar-png-1.png":"https://gelistiricim.herokuapp.com/uploads/"+snapshot.data.image),
                            ),
                          );
                        });
                  }
                },
              ),
              ListTile(
                title: Text("Makale Oluştur"),
                leading: Icon(
                  FontAwesomeIcons.fileSignature,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateArticlesPage()));
                },
              ),
              ListTile(
                title: Text("Makaleler"),
                leading: Icon(
                  FontAwesomeIcons.fileAlt,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ArticlesPage()));
                },
              ),

              ListTile(
                title: Text("Çıkış Yap"),
                leading: Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  // ignore: unnecessary_statements
                  sharedPreferences.getString("token") == null;
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
              ),
            ],
          ),
        ),
        body:
            /*_pageOptions[_selectedPage]*/
            SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleSinglePage(
                                article: postData[currentPage.toInt()],
                              )));
                },
                child: Stack(
                  children: <Widget>[
                    CardScrollWidget(currentPage),
                    Positioned.fill(
                      child: PageView.builder(
                        itemCount: articles.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: <Widget>[
                    Text("Makaleler",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    SingleChildScrollView(
                        child: FutureBuilder(
                            future: getPosts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
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
                                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return Stack(children: <Widget>[

                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleSinglePage(article: snapshot.data[index],)));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(15, 10, 20, 10),
                                            height: 170,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.8),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                  offset: Offset(
                                                      0, 3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(125, 10, 20, 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          snapshot.data[index].title,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w600),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    snapshot.data[index].content,
                                                    maxLines: 5,
                                                  ),
                                                  SizedBox(height: 20,),
                                                  GestureDetector(
                                                    onTap:() {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> OtherUserProfilePage(username: snapshot.data[index].userName,)));
                                                    } ,
                                                    child: Text(
                                                      snapshot.data[index].userName,
                                                      maxLines: 5,

                                                    ),
                                                  ),
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
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image(
                                              width: 110,
                                              image: NetworkImage(snapshot.data[index].image=="none"?"https://i.ya-webdesign.com/images/avatar-png-1.png":
                                                snapshot.data[index].image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ]);
                                    });
                              }
                            })),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  Text("Eğitimler",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 46.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      )),
                  Container(
                      height: 250,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: FutureBuilder(
                          future: getEdus(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Center(
                                  child: Text("yükleniyor..."),
                                ),
                              );
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: ScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 25, horizontal: 12),
                                    child: Container(
                                      height: 220,
                                      width: 135,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 10,
                                                offset: Offset(0.0, 10.0))
                                          ]),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EducationSinglePage(
                                                        education: snapshot
                                                            .data[index],
                                                      )));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    topRight:
                                                        Radius.circular(30)),
                                                child: Image(
                                                  image: NetworkImage(snapshot.data[index].image=="null"?"https://i.ya-webdesign.com/images/avatar-png-1.png":
                                                    snapshot.data[index].image,
                                                  ),
                                                  width: double.infinity,
                                                  height: 130,
                                                  fit: BoxFit.cover,
                                                )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 8, right: 8),
                                              child: Text(
                                                snapshot.data[index].title,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          })),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
        /*bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,

          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Anasayfa')),
            BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                title: Text('Oyun')),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text('Favorilerim')),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profilim'),),
          ],
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.deepPurple,
          showUnselectedLabels: true,
        ),*/
      ),
    );
  }

  List<Widget> educations() {
    List<Widget> educationList = List();
    for (int i = 0; i < educationsData.length; i++) {
      var educationItem = Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        child: Container(
          height: 220,
          width: 135,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 10.0))
              ]),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EducationSinglePage(
                            education: educationsData[i],
                          )));
            },
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Image.asset(educationsData[i].image,
                      width: double.infinity, height: 130, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                  child: Text(
                    educationsData[i].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      );
      educationList.add(educationItem);
    }
    return educationList;
  }
}
