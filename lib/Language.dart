import 'package:flutter/material.dart';

class Language {
  List eng=["Editor's Choice","Nature","Landscape","Space","Food","Macro","Flower","City","Sport","Fashion","Street"];
  List tr=["Editörün Seçimi","Doğa","Manzara","Uzay","Yemek","Makro","Çiçek","Şehir","Spor","Moda","Sokak"];

}

class Photos{
  List categoryPhoto=["lib/photos/editors chose.jpg",
                      "lib/photos/nature.jpg",
                      "lib/photos/landscape.jpeg",
                      "lib/photos/space.jpg",
                      "lib/photos/food.jpg",
                      "lib/photos/macro.jpg",
                      "lib/photos/flower.jpg",
                      "lib/photos/city.jpg",
                      "lib/photos/sport.jpg",
                      "lib/photos/fasion.jpg",
                      "lib/photos/street.jpg"


                         ];



}
class AboutEng extends StatelessWidget {
  const AboutEng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("About the App"),),
      body:  Center(child:
      Column(children: [
        Spacer(flex:5),
        Text("Photos are provided by www.pixabay.com."),
        Spacer(flex: 1,),

        Container(width: 150,height: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Image.asset("lib/flags/medium_rectangle_a.png",)),
        Spacer(flex: 1,),
        Text("App Creator: App from MK"),
        Spacer(flex:5),





      ],),),
    );
  }
}
class AboutTr extends StatelessWidget {
  const AboutTr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Uygulama Hakkında")),
      body:  Center(child:
      Column(children: [
        Spacer(flex:5),
        Text("Fotoğraflar www.pixabay.com sitesi tarafından sağlanmaktadır."),
        Spacer(flex: 1,),
        Container(width: 150,height: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Image.asset("lib/flags/medium_rectangle_a.png",)),
        Spacer(flex:5),





      ],),),
    );
  }
}

