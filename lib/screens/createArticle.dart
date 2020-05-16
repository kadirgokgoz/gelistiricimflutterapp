import 'package:flutter/material.dart';
import 'package:gelistiricimapp/mainPage.dart';
import 'package:gelistiricimapp/screens/kayitol.dart';
import 'package:gelistiricimapp/widgets/bottom_navigation_bar.dart';
import 'package:gelistiricimapp/widgets/social_log_in_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

class CreateArticlesPage extends StatefulWidget {
  CreateArticlesPage() : super();

  final String title = "DropDown";

  @override
  CreateArticlesState createState() => CreateArticlesState();
}
/*class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List <Company> getCompanies() {
    return <Company>[
      Company (1,'Java'),
      Company (2,'C++'),
      Company (3,'Python'),
    ];
  }
}*/

class CreateArticlesState extends State<CreateArticlesPage> {

  /*List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;*/

  @override
  void initState(){
    /*_dropdownMenuItems =  buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;*/
    super.initState();
  }

  /*List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies){
    List<DropdownMenuItem<Company>> items = List();
    for(Company company in companies){
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
  onChangeDropdownItem(Company selectedCompany){
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }*/
  postArticle(String title, content) async {
    print(title+" "+content);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString("token");
    Map data = {
      'title': title,
      'content': content
    };

    var response = await http.post(
        "https://gelistiricim.herokuapp.com/api/post",  headers: {'x-access-token': token} ,body: data);
    if (response.statusCode == 200) {
      print(response.body);
    }
    else {
      print(response.body);
    }
  }
  alertGoster(BuildContext context)
  {
    var alert=AlertDialog(title: Text("Eksik veri"),content: Text("Konu ve içerik boş bırakılamaz"),actions: <Widget>[MaterialButton(elevation:5,child:Text("kapat"),onPressed: (){Navigator.of(context).pop();},)],);
    return showDialog(context: context,builder: (context){ return alert;});
  }
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController contentController = new TextEditingController();
  Widget detail(BuildContext context)
  {
    final subjectIDField = TextField(
      controller: titleController,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Başlık",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
      ),
    );
    final articlesIDField = TextField(

      controller: contentController,
      maxLines: 14,
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Makalenizi yazmaya başlayabilirsiniz....\n(En az 24 karakter uzunluğunda olmalıdır)",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0))
      ),
    );

    final articleSaveButton  = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(34.0),
      color: Colors.purple[600],
      child: MaterialButton(
        splashColor: Colors.purple[100],
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {titleController.text == "" || contentController.text == "" ? alertGoster(context) :postArticle(titleController.text,contentController.text);
        },
        child: Text("Makaleyi Oluştur ve Paylaş",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white,fontStyle: FontStyle.normal),
        ),
      ),
    );
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 8.0,),
            subjectIDField,

            SizedBox(height: 8.0),
            articlesIDField,

            SizedBox(height: 15.0),
            articleSaveButton,
          ],
        ),
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(

          leading:
            FlatButton(
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
        body:  Container(
          child: Center(
            child: ListView(

              children: <Widget>[
                Image.asset("assets/image1412.png",height: 150,),
                //Image.asset("assets/image1412.png",height: 200,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      detail(context),
                    ],
                  ),
                ),


              ],

            ),

          ),

        ),

      ),

    );

  }
}





