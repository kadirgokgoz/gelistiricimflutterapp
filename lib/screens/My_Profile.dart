import 'package:flutter/material.dart';
import 'package:gelistiricimapp/main.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"User Profile",
      debugShowCheckedModeBanner: false,
      home:UserProfilePage(),

    );
  }
}
class UserProfilePage extends StatelessWidget {
  final String _fullName = "Hasancan İsbeceren";
  final String _status = "Software Developer";
  final String _bio = " Microsoft’un kurucusu Bill Gates, 1955 yılında dünyaya geldi. Zengin bir ailenin çocuğu olarak Seattle’da doğan Gates, elindeki kaynakları doğru şekilde kullanmayı başararak bugün dünyanın sayılı zenginlerinden biri oldu. Şans, vizyon ve çok çalışmanın bir eseri olan başarı hikayesiyle “her eve bir bilgisayar sokabilmek” vizyonunu dünyaya getiren bu ünlü kişi, 1975 yılında Microsoft’u kurdu ve kısa zaman içinde dünyanın sayılı multimilyarderlerinden biri haline geldi.";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 3.0,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgroundMy.jpg'),
            fit: BoxFit.cover,

          )
      ),
    );
  }
  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/testProfile.jpg'),
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
  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'yazi',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );
    return Text(
      _fullName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
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
          _buildStatItem("Takipçiler", _followers),
          _buildStatItem("Makale Sayısı", _posts),
          _buildStatItem("Basarı Puanı", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'yazi',
      color: Color(0xFF799497),
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
    );

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(6.0),
      child: Text(
        _bio,
        textAlign: TextAlign.center,
        style: bioTextStyle,
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
           "Get in Touch with ${_fullName.split(" ")[0]},",
          style: TextStyle(fontFamily: 'yazi', fontSize: 16.0),
        ),
      );
    }

    Widget _buildArticle() {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(100, 10, 20, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                              "saddsadsa" "",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("dfsfdsfds"),

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
                    width: 100,
                    image: AssetImage(
                      "assets/backgroundMy.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              _buildSeparator(Size(500,2)),
            ],
          );
        },
      ),
    );
   }

    Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),

      child: Row(
        children: <Widget>[
          Expanded(
            child:InkWell(
                onTap:() => print ("followed") ,
                child:Container (
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.deepPurple[600] ,

                ),
                child: Center(
                  child: Text(
                    "TAKİP ET",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                  ),
              ),
                ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
          Expanded(
          child: InkWell(
            onTap: () => print("Message"),
            child: Container(
              height: 40.0,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "İLETİŞİM KUR",
                    style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
              ),
            ),
          ),
        ),
       ],
      ),
    );
}


  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[

            _buildCoverImage(screenSize),
            SafeArea(
              child: Column(
                children: <Widget>[

                  SizedBox(height: screenSize.height / 6.4),

                  _buildProfileImage(),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildButtons(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  _buildGetInTouch(context),
                  SizedBox(height: 6.0),
                  Text("Paylaşımlar",style: TextStyle(
                      fontFamily: 'yazi',
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),),
                  SizedBox(height: 10.0),
                  _buildArticle(),

                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}

