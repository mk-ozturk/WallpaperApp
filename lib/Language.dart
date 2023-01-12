import 'package:flutter/material.dart';

class Language {
  List eng=["Editor's Choice","Nature","Landscape","Space","Food","Macro","Flower","City","Sport","Fashion","Street"];
  List tr=["Editörün Seçimi","Doğa","Manzara","Uzay","Yemek","Makro","Çiçek","Şehir","Spor","Moda","Sokak"];

}

class Photos{
  List categoryPhoto=[
                          "https://www.gentas.com.tr/wp-content/uploads/2021/05/3155-antrasit-gri_renk_g474_1250x1000_lld3bs4n.jpg",
                        "https://images.pexels.com/photos/15286/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600",
                       "https://images.pexels.com/photos/2440021/pexels-photo-2440021.jpeg?auto=compress&cs=tinysrgb&w=600",
                        "https://cdn.pixabay.com/photo/2016/07/02/12/21/eclipse-1492818__340.jpg",
                        "https://cdn.pixabay.com/photo/2016/12/26/17/28/spaghetti-1932466__340.jpg",
                        "https://cdn.pixabay.com/photo/2016/06/05/22/47/abstract-1438382__340.jpg",
                         "https://cdn.pixabay.com/photo/2013/07/04/16/22/rose-143184__340.jpg",
                         "https://cdn.pixabay.com/photo/2016/06/29/22/02/parking-space-1487891__340.jpg",
                          "https://images.pexels.com/photos/163403/box-sport-men-training-163403.jpeg?auto=compress&cs=tinysrgb&w=600",
                          "https://cdn.pixabay.com/photo/2022/07/21/20/25/converse-7336903__340.jpg",
                          "https://cdn.pixabay.com/photo/2013/03/02/02/41/alley-89197__340.jpg"];



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

