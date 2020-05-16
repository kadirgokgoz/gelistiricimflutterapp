class Author {
  String id;
  String username;
  
  Author({this.id,this.username});

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(
        id: json['_id'],
        username: json['userName']
    );
  }
}