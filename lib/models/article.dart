import 'Author.dart';

class Article{
String title;
String image;
String content;
String userName;


Article({this.title,this.content, this.image,this.userName});

factory Article.fromJson(Map<String, dynamic> parsedJson){
  return Article(
      title: parsedJson['title'],
      image: parsedJson['image_url'],
      content: parsedJson['content'],
      //userName: Author.fromJson(parsedJson['author'])
  );
}

}