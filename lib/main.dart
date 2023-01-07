import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:walpaper_app/Parsecode.dart';
import 'package:walpaper_app/PhotoPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallpapers',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {






  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String apiKey="32652039-5de9198ed878c2c8b355d4561";

 List<Hit> parseImgs(String cevap){
   return ImgParse.fromJson(jsonDecode(cevap)).hits;

   }

   Future<List<Hit>> search(String id) async{

   var url=Uri.parse("https://pixabay.com/api/?key=$apiKey&q=$id");
    var cevap= await http.get(url);

   return parseImgs(cevap.body);

   }

  String btnSearch="";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Walpapers"),
      ),
      body: FutureBuilder(
        future: search(btnSearch),
        builder: (context, AsyncSnapshot<List<Hit>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            debugPrint("başarıyla baglanıldı");
            var imgdata=snapshot.data;
            return GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                ),
                itemCount: imgdata?.length,
                itemBuilder: (context, i){
              var images=imgdata![i];
              return Card(child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Imgdetail(images.webformatUrl)));
                  },
                  child: Image.network(images.webformatUrl)),) ;


                });
          } else {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        },
      ),
      //floataction button ekleyip kategorilere bir bak.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        setState(() {
          btnSearch="summer";
        });


        },
        backgroundColor: Colors.green,
        child: Text("Summer"),
      ),
    );
  }
}