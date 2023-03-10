import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:walpaper_app/CropPage.dart';
import 'package:walpaper_app/FullScrean.dart';
import 'package:url_launcher/url_launcher.dart';


class Imgdetail extends StatelessWidget {


  String imgUrl;
  bool  lang;
  String creature;
  String cretureImg;
  bool goToHome=true;



  Imgdetail(this.imgUrl,this.lang,this.creature,this.cretureImg);


  Future<void> _launchUrl(crt) async {
    var url="https://pixabay.com/users/$crt";
    await launchUrl(Uri.parse(url));



  }


  Future<void> HomeScrean(urlImg) async{

    String result;
    try {
      result = await AsyncWallpaper.setWallpaper(
        url: urlImg,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,

      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
    print(result);
  }
  Future<void> LockScreen(urlImg) async {
    String result;

    try{
      result = await AsyncWallpaper.setWallpaper(
        url:urlImg,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
      )
          ? "Wallpaper set":"Failed to get wallpaper.";
    } on PlatformException{result="Failed to get wallpaper.";}

    print(result);

  }

  Future<void> BothScreen(imgUrl)async {
    String result;

    try {
      result= await AsyncWallpaper.setWallpaper(
          url: imgUrl,
          wallpaperLocation: AsyncWallpaper.BOTH_SCREENS)?
      "Walpaper set":"Failed";
    } on PlatformException{result="Failed to get wallpaper.";}
    print(result);
  }





  @override
  Widget build(BuildContext context) {
    var scrsize= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(lang==true ? "Photo Detail":"Fotoğraf Detayı"),
        actions: [
          PopupMenuButton(icon: Icon(Icons.more_vert),itemBuilder: (context)=>[
            PopupMenuItem(child: Text(lang==true ?"Set as Lock Screen":"Kilit Ekranı Olarak Ayarla"),
              value: 1,),
            PopupMenuItem(child: Text(lang==true ?"Set as Home Screen":"Arka Plan Olarak Ayarla"),
              value: 2,),
            PopupMenuItem(child: Text(lang==true ?"Set as Lock Screen and Home Screen":"Kilit ve Arka Plan Olarak Ayarla "),
              value: 3,),
            PopupMenuItem(child: Text(lang==true ?"Download":"İndir"),
              value: 4,)

          ],
            onCanceled: (){print("Do not choosing");},
            onSelected: (menuItemValue){
              if(menuItemValue==1){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CropPage(imgUrl)));
              }
              if(menuItemValue==2){print("Arka plan olarak ayarlandı" );
              HomeScrean(imgUrl);}
              if(menuItemValue==3){
                print("Arka plan ve kilit ekranı plan olarak ayarlandı" );
                BothScreen(imgUrl);}
              if(menuItemValue==4){print("indir seçildi" );
              }

            },)
        ],

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child:
          Column(
            children: [
              GestureDetector(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl)));
              },
                child: SizedBox(
                  width: 300,
                  height: 520,
                  child: Image.network(imgUrl, fit: BoxFit.cover,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        child: Image.network(cretureImg)),
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Creature",),
                          GestureDetector(onTap: (){
                            _launchUrl(creature); },
                              child: Text("${creature}",
                                style: TextStyle(color:Colors.blue,
                                    decoration: TextDecoration.underline ),)),
                        ],
                      ),),
                  ],
                ),
              )
            ],
          ),),
        ),
      ),

    );
  }
}
