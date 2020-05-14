import 'package:flutter/material.dart';
import 'package:gelistiricimapp/screens//sign_in_page.dart';
import 'package:gelistiricimapp/screens//kullanicigiris.dart';
import 'package:gelistiricimapp/screens/kullanicigiris.dart';
import 'package:gelistiricimapp/screens/login_page.dart';
import 'package:gelistiricimapp/screens/sign_in_page.dart';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';
import 'package:gelistiricimapp/screens/My_Profile.dart';
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false ,
      theme: ThemeData(
        fontFamily: "yazi",
        primarySwatch: Colors.purple,
      ),


      home: bottomNavigationBar(),


    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gelistiricimapp/screens/My_Profile.dart';
import 'package:gelistiricimapp/screens/articles_page.dart';
import 'package:gelistiricimapp/screens/education_page.dart';
import 'package:gelistiricimapp/screens/education_single_page.dart';
import 'package:gelistiricimapp/screens/sign_in_page.dart';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';
import 'data.dart';
import 'educationdata.dart';
import 'screens/article_single_page.dart';
import "widgets/card_scroll_widget.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
import 'package:gelistiricimapp/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  SharedPreferences.setMockInitialValues({});
  runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepPurple,
          primarySwatch: Colors.deepPurple, accentColor: Colors.purple),
      home: bottomNavigationBar(),
      debugShowCheckedModeBanner: false,
    ));}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
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

  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }
  var currentPage = articles.length - 1.0;
  List postData;
  Future<String> getPosts() async{
    http.Response response=await http.get("https://gelistiricim.herokuapp.com/api/post");

    setState(() {
      postData=jsonDecode(response.body);
    });

    return "Basarili";

  }


  List<Widget> educations() {
    List<Widget> educationList = List();
    for (int i = 0; i < educationsData.length; i++) {
      var educationItem = Padding(
        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
        child: Container(
          height: 220,
          width: 135,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30),boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 10.0))
          ]),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EducationSinglePage(education: educationsData[i],)));
            } ,
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30) ),
                  child: Image.asset(educationsData[i].image,
                      width: double.infinity, height: 130, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 8,right: 8),
                  child: Text(educationsData[i].title,textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 16
                  ),),
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

  @override
  Widget build(BuildContext context) {
    getPosts();
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
            FlatButton(
              onPressed: () {
                sharedPreferences.clear();
                sharedPreferences.commit();
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
              },
              child: Text("Log Out", style: TextStyle(color: Colors.deepPurple)),
            ),
            /*GestureDetector(onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder:
                    (context) => UserProfile()
                ),
              );
            },
              child: Container(
                  margin: EdgeInsets.only(right: 15), child: Icon(Icons.person)),
            )*/
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Kadir"),
                accountEmail: Text("kdrgkgz1998@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://i.ya-webdesign.com/images/avatar-png-1.png"),
                ),
              ),
              ListTile(
                title: Text("Anasayfa"),
                leading: Icon(
                  Icons.home,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
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
                title: Text("Eğitim"),
                leading: Icon(
                  FontAwesomeIcons.university,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EducationPage()));
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ArticleSinglePage(
                                //article: articles[currentPage.toInt()],
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) { debugPrint(postData[index]["_id"]); return ArticleSinglePage(
                                            id: postData[index]["_id"],
                                          );}));
                            },
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
                                  height: 170,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
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
                                    padding:
                                        EdgeInsets.fromLTRB(100, 10, 20, 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 120,
                                              child: Text(
                                                  postData[index]["title"],//postData[index]["title"],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          postData[index]["body"],
                                          maxLines: 5,
                                        ),
                                      ],
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
                                      width: 110,
                                      image: NetworkImage(
                                        postData[index]["image_url"],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: educations(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),

      ),
    );
  }



  /*Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text('Anasayfa')),
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad), title: Text('Oyun')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), title: Text('Favorilerim')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profil')),
        ],
        currentIndex: -_currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.deepPurple,
        showUnselectedLabels: true,
      ),
    );
  }*/
}
*/