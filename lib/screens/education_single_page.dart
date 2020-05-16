import 'package:flutter/material.dart';
import 'package:gelistiricimapp/models/article.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gelistiricimapp/models/education.dart';
import 'package:gelistiricimapp/screens/education_details_page.dart';
import 'package:gelistiricimapp/screens/education_page.dart';
import "package:gelistiricimapp/widgets/bottom_navigation_bar.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

class EducationSinglePage extends StatefulWidget {
  final Education education;

  EducationSinglePage({this.education});

  @override
  _EducationSinglePageState createState() => _EducationSinglePageState();
}

class _EducationSinglePageState extends State<EducationSinglePage> {
  List<Education> eduData=[];

  Education lesson;

  Future<List<Education>> getEdus() async{

    var data=await http.get("https://gelistiricim.herokuapp.com/api/education/detail/"+widget.education.id);
    var jsondata=json.decode(data.body);
    var gelenVeri=jsondata["data"];
    for (var post in gelenVeri)
    {

      lesson=Education(title: post["title"],content: post["body"]);
      eduData.add(lesson);
    }

    return eduData;


  }

  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading:FlatButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => EducationPage()), (Route<dynamic> route) => false);

                },
                child: Icon(Icons.arrow_back,color: Colors.deepPurple,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
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

              ],
              expandedHeight: (MediaQuery.of(context).size.height / 2),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:Image(
                image: NetworkImage(widget.education.image, ),fit: BoxFit.cover),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(_dynamicListFunction,
                  childCount: 1),
            ),

          ],
        ),

      ),
    );
  }

  Widget _dynamicListFunction(BuildContext context, int index) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                  future: getEdus(),
                  builder: (BuildContext context,AsyncSnapshot snapshot){
                    if(snapshot.data==null){return Container(child: Center(child: Text("yükleniyor..."),),);}
                    else{
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Stack(
                            children:<Widget>[
                              GestureDetector(
                                onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=> EducationDetailsPage(education: snapshot.data[index],imageurl: widget.education.image,)));
                                },
                                child: Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: 200,
                                            child: Text(
                                              snapshot.data[index].title,
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.w600),
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
                                        snapshot.data[index].content,maxLines: 5,),
                                    ],
                                  ),
                                ),
                            ),
                              ),]
                          );
                        },
                      );}
                  }
              )
            ],
          ),
        ),
      ],
    );
  }
}
