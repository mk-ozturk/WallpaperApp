import 'package:flutter/material.dart';



class CropPage extends StatefulWidget {

  String img;


  CropPage(this.img);

  @override
  State<CropPage> createState() => _CropPageState();
}

class _CropPageState extends State<CropPage> {



  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return
      SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Image.network(widget.img, fit: BoxFit.cover  ));






  }
}
