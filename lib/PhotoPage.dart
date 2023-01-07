import 'package:flutter/material.dart';
import 'package:walpaper_app/FullScrean.dart';

class Imgdetail extends StatelessWidget {


   String imgUrl;


   Imgdetail(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotoğraf Detayı"),
        actions: [
         PopupMenuButton(icon: Icon(Icons.more_vert),itemBuilder: (context)=>[
           PopupMenuItem(child: Text("Kilit Ekranı Olarak Ayarla"),
           value: 1,),
           PopupMenuItem(child: Text("Arka Plan Olarak Ayarla"),
           value: 2,),
           PopupMenuItem(child: Text("Kilit ve Arka Plan Olara Ayarla "),
             value: 3,),
           PopupMenuItem(child: Text("İndir"),
             value: 4,)

         ],
         onCanceled: (){print("Do not choosing");},
         onSelected: (menuItemValue){
           if(menuItemValue==1){print("Kilit ekranı olarak ayarlandı");}
           if(menuItemValue==2){print("Arka plan olarak ayarlandı" );}
           if(menuItemValue==3){print("Arka plan ve kilit ekranı plan olarak ayarlandı" );}
           if(menuItemValue==4){print("indir seçildi" );}

         },)
        ],

      ),
      body: Center(child:
        Card(
          child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl)));
              },
             child: Image.network(imgUrl)),
        ),),

    );
  }
}
