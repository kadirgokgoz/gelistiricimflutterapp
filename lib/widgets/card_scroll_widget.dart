import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:gelistiricimapp/models/article.dart';
import "package:flutter/material.dart";
import 'package:gelistiricimapp/data.dart';
import "package:http/http.dart" as http;


class CardScrollWidget extends StatelessWidget {
  Article article;
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  static var cardAspectRatio = 12.0 / 16.0;
  var widgetAspectRatio = cardAspectRatio * 1.2;

  CardScrollWidget(this.currentPage);
  List<Article> postData=[];



  Future<List<Article>> getPosts() async{
    var data=await http.get("https://gelistiricim.herokuapp.com/api/post");
    var jsondata=json.decode(data.body);
    var veri=jsondata["data"];
    for (var post in veri)
    {
      article=Article(title: post["title"],content: post["content"],image: post["image_url"]);
      postData.add(article);
    }

    return postData;


  }
  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < 6; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem=Positioned.directional(
                top: padding + verticalInset * max(-delta, 0.0),
                bottom: padding + verticalInset * max(-delta, 0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: FutureBuilder(future: getPosts(),
                  builder: (BuildContext context,AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(child: Text(""),),);
                    }
                    else {
                      return ListView.builder(shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: ScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(3.0, 6.0),
                                      blurRadius: 10.0)
                                ]),
                                child: AspectRatio(
                                  aspectRatio: cardAspectRatio,
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: <Widget>[
                                      Image(image: NetworkImage(
                                          snapshot.data[i].image),
                                          fit: BoxFit.cover),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 8.0),
                                              child: Text(
                                                  snapshot.data[i].title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 25.0,
                                                      fontFamily: "SF-Pro-Text-Regular")),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0, bottom: 12.0),
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 22.0,
                                                    vertical: 6.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.deepPurple,
                                                    borderRadius: BorderRadius
                                                        .circular(20.0)),
                                                child: Text("Gözat",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    }
                  }),
              );


          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}