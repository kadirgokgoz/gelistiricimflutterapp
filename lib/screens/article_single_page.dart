import 'package:flutter/material.dart';
import 'package:gelistiricimapp/models/article.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gelistiricimapp/screens/articles_page.dart';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';

class ArticleSinglePage extends StatelessWidget {
  final Article article;
  String id;

  ArticleSinglePage({this.article});

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
                  Navigator.of(context).pop();

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
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(FontAwesomeIcons.heart))
              ],
              expandedHeight: (MediaQuery.of(context).size.height / 2),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background:Image(

                  image: NetworkImage(
                    article.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(_dynamicListFunction,
                  childCount: 1),
            )
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
              Center(
                child: Text(
                  article.title,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 25.0,
                      fontFamily: "SF-Pro-Text-Regular"),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(article.content,),
            ],
          ),
        ),
      ],
    );
  }
}
