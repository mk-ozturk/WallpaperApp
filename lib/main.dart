import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:walpaper_app/AboutPage.dart';
import 'package:walpaper_app/Language.dart';
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



 void Lang(bool  change){

    if(change==true){category=Language().eng;}
    else {category=Language().tr;}


  }
  String apiKey="32652039-5de9198ed878c2c8b355d4561";

 List<Hit> parseImgs(String cevap){
   return ImgParse.fromJson(jsonDecode(cevap)).hits;

   }

   Future<List<Hit>> search(String id) async{
   String api= btnLang==true ? "https://pixabay.com/api/?key=$apiKey&$id&min_width=1080&min_height=1920&orientation=vertical": "https://pixabay.com/api/?key=$apiKey&$id&min_width=1080&min_height=1920&orientation=vertical&lang=tr";
   var url=Uri.parse(api);
    var cevap= await http.get(url);
      print("api $id");
   return parseImgs(cevap.body);

   }
 var langClass=Language();
 List searchWords=Language().eng;
 List category=Language().eng;
 bool btnLang=true;

  String btnSearch="order=latest";

  final TextEditingController textFSearch=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    final scrSizeWidth=screenSize.width;
    final scrSizeHeight=screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText:btnLang==true ?"Write for Search":"Aramak için yazınız", ),
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          controller: textFSearch,
          onSubmitted: (text){
            btnSearch="q=$text";
            textFSearch.clear();
            print("onsumbit$text");
          },
        ),
        actions: [Tab(icon: Image.asset("lib/flags/Wallpapers.png",),)],

// türk.e aramalarda sorun yaşayacaksın bu aramalar için bir çare bul. api üzerinde değişiklikle rile bunu yapabilirsin tr abisine bağlanabilrisin


      ),

      //Body kısmı
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
                crossAxisCount: 2,
                ),
                itemCount: imgdata?.length,
                itemBuilder: (context, i){
              var images=imgdata![i];
              return Card(child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Imgdetail(images.largeImageUrl,btnLang)));
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
      drawer: SizedBox(
        width: 250,
        //Drawer kısmı
        child: Drawer(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 80,width: double.infinity,
                    child: DrawerHeader(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(btnLang==true?"Categories":"Kategoriler",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      ),
                      decoration: BoxDecoration(color: Colors.blue),
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: scrSizeHeight-130,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: category.length,
                      itemBuilder: (context, i){
                        return SizedBox(
                            height: 50,
                            child: Card(child: TextButton(

                               onPressed: (){
                                print("pressed");
                                setState(() {
                                  if(category[i]==category[0]){btnSearch="order=latest&q=wallpaper";}
                                 else if (category[i]==category[1]){btnSearch="editors_choice=true";}else{btnSearch="q=${category[i].toLowerCase()}+${btnLang==true? "wallpaper":"duvar+kağıdı"}";}});
                                Navigator.pop(context);


                              },
                              child: Text(category[i],style: TextStyle(color: Colors.black,),),
                            style: TextButton.styleFrom(
                              minimumSize: Size.fromWidth(150),
                              padding: EdgeInsets.only(left: 8),
                              alignment: Alignment.centerLeft
                            ),),));
                    }

                    ),
                  ),




                ],
              ),
              Container(
                  color: Colors.lightBlue,
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                              btnLang=!btnLang;
                              Lang(btnLang);
                          });
                        }
                        ,child: SizedBox(width: 75,
                        child: btnLang==true ? Image.asset("lib/flags/istockphoto-880562092-170667a.jpg"):Image.asset("lib/flags/images.png"),),
                      ),
                      Container(width: 175,
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutPage(btnLang)));
                          },
                          child: Text(btnLang==true?"About the App":"Uygulama Hakkında",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),

                        )
                      ),
                    ],
                  ))
            ],
          ),






        ),
      ),


    );
  }
}