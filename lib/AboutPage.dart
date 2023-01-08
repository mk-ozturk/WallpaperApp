import 'package:flutter/material.dart';
import 'package:walpaper_app/Language.dart';

class AboutPage extends StatelessWidget {


  bool lang;


  AboutPage(this.lang);

  @override
  Widget build(BuildContext context) {
    return lang==true ? AboutEng():AboutTr();

  }
}
