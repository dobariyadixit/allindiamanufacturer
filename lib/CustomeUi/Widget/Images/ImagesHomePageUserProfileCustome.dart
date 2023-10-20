import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ImagesProperty/ImagesSize.dart';
import 'package:flutter/material.dart';

class ImagesCustome extends StatefulWidget {

  String imagePath;

   ImagesCustome({super.key , required this.imagePath});

  @override
  State<ImagesCustome> createState() => _ImagesCustomeState();
}

class _ImagesCustomeState extends State<ImagesCustome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(width: 1,color: Colors.black)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          //   borderRadius: BorderRadius.circular(100),
          child:  FadeInImage.assetNetwork(
            placeholder: Assets.Dammyimages,
            image: widget.imagePath,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
            fit: BoxFit.cover,
          ),/*Image.network(
            widget.imagePath,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),*/
        ),
      ),
    );
  }
}
