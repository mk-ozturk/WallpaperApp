import 'package:flutter/material.dart';

class Language {
  List eng=["Home Page","Editor's Choice","Summer","Winter","Christmas","Car","Flower"];
  List tr=["Ana Sayfa","Editörün Seçimi","Yaz","Kış","Yıl Başı","Araba","Çiçek"];




}

class AboutEng extends StatelessWidget {
  const AboutEng({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About the App"),),
      body:  Center(child:
      Column(children: [
        Spacer(flex:5),
        Text("Photos are provided by www.pixabay.com."),
        Spacer(flex: 1,),
        Container(width: 150,height: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Image.asset("lib/flags/medium_rectangle_a.png",)),
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

