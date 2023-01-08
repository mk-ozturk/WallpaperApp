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

  List category=["Editor's Choice","Summer","Winter","Christmas","Car","Flower"];


  String apiKey="32652039-5de9198ed878c2c8b355d4561";

 List<Hit> parseImgs(String cevap){
   return ImgParse.fromJson(jsonDecode(cevap)).hits;

   }

   Future<List<Hit>> search(String id) async{

   var url=Uri.parse("https://pixabay.com/api/?key=$apiKey&$id&min_width=1080&min_height=1920&orientation=vertical");
    var cevap= await http.get(url);

   return parseImgs(cevap.body);

   }

  String btnSearch="order=latest";



  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    final scrSizeWidth=screenSize.width;
    final scrSizeHeight=screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpapers"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Imgdetail(images.largeImageUrl)));
                  },
                  child: Image.network(images.previewUrl)),) ;


                });
          } else {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 80,width: double.infinity,
                  child: DrawerHeader(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Categories", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    ),
                    decoration: BoxDecoration(color: Colors.blue),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                  ),
                ),
                Container(height: scrSizeHeight-130,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: category.length,
                    itemBuilder: (context, i){
                      return SizedBox(
                          height: 50,
                          child: Card(child: Align(
                            alignment: Alignment.centerLeft,
                              child: SizedBox(
                                  width: double.infinity,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextButton(
                                        style: TextButton.styleFrom(fixedSize: Size(double.infinity, double.infinity)),
                                        onPressed: (){
                                          print("basıldı");

                                          setState(() {
                                            if(category[i]!="Editor's Choice"){btnSearch="q=${category[i].toLowerCase()}+wallpaper";}
                                            else{btnSearch="editors_choice=true";
                                          }});
                                          Navigator.pop(context);


                                        },
                                        child: Text(category[i],style: TextStyle(color: Colors.black,),),)))),));
                  }

                  ),
                ),




              ],
            ),
            Container(
                color: Colors.lightBlue,
                height: 50,
                width: double.infinity,
                child: Center(child: Text("About the App",style: TextStyle(fontWeight: FontWeight.bold),)))
          ],
        ),






      ),


    );
  }
}