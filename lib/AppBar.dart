
import 'package:allindiamanufacturer/Screen/AboutCommunityScreen/AboutCommunityScreen.dart';
import 'package:allindiamanufacturer/Screen/NewPostScreen/NewPostScreen.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:allindiamanufacturer/TextProperty/Textsize.dart';
import 'package:flutter/material.dart';

class AppBarCustome extends StatefulWidget {
  const AppBarCustome({super.key});

  @override
  State<AppBarCustome> createState() => _AppBarCustomeState();
}

class _AppBarCustomeState extends State<AppBarCustome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutCommunityScreen(),));
       //   Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostScreen(),));
        },
        child: Container(
        width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          child: Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Textfile.allindiamanufacturr,style: TextStyle(fontSize: TextSize.appBarTitleAllInadiyaManufacturer,fontWeight: FontWeight.bold),),
              Text(Textfile.Members520,style: TextStyle(fontSize: TextSize.appBarTitle520Members),),
            ],
          ),
        ),
      ),
    );
  }
}
