import 'dart:convert';
import 'package:bordered_text/bordered_text.dart';
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
 List catPhoto=Photos().categoryPhoto;

  String btnSearch="order=latest&q=wallpaper";

  final TextEditingController textFSearch=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize=MediaQuery.of(context).size;
    final scrSizeWidth=screenSize.width;
    final scrSizeHeight=screenSize.height;
    print(scrSizeHeight.toString());
    final double viewH=scrSizeHeight/3;
    final double viewW=scrSizeWidth/2;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText:btnLang==true ?"Write for Search":"Aramak için yazınız", ),
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          controller: textFSearch,
          onSubmitted: (text){
            String noSpace=text.replaceAll(" ", "+");
            btnSearch="q=$noSpace";
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
                crossAxisCount: 3,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                mainAxisExtent: viewW,


                ),
                itemCount: imgdata?.length,
                itemBuilder: (context, i){
              var images=imgdata![i];
              return Container(

                  child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Imgdetail(images.largeImageUrl,btnLang,images.user,images.userImageUrl)));
                  },
                  child: Image.network(images.previewUrl,fit: BoxFit.cover,),),) ;


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
                        child: Text(btnLang==true?"Categories":"Kategoriler",textAlign: TextAlign.center,
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

                        return Stack(
                          children: [
                            Container(
                                height: 50.31,
                                width: 250,
                                child: Image.network(
                                  catPhoto[i],
                                  fit: BoxFit.cover ,
                                  )),
                           SizedBox(
                                height: 45,
                                child: TextButton(

                                   onPressed: (){
                                    print("pressed");
                                    setState(() {
                                      if(category[i]==category[0]){btnSearch="editors_choice=true";}
                                     else{btnSearch="q=${category[i].toLowerCase()}+${btnLang==true? "wallpaper":"duvar+kağıdı"}";}});
                                    Navigator.pop(context);


                                  },
                                  child: BorderedText(
                                    strokeWidth: 5,
                                    strokeColor: Colors.black,
                                    child: Text(category[i],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                           ),),
                                  ),
                                style: TextButton.styleFrom(
                                  minimumSize: Size.fromWidth(250),
                                  padding: EdgeInsets.only(left: 8),
                                  alignment: Alignment.center
                                ),)),
                          ],
                        );
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