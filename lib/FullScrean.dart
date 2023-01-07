import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  String imgUrl;


  FullScreen(this.imgUrl);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        panEnabled: false,
        boundaryMargin: EdgeInsets.all(80),
        minScale: 0.5,
        maxScale: 4,
        child: Image.network(imgUrl),
        
      ),
    );
  }
}
