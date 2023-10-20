import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesHomePageUserUpaloadCustome extends StatefulWidget {

  String imagePath;
  String imagUploadTime;
  FontWeight fontWeight;

   ImagesHomePageUserUpaloadCustome({super.key,
   required this.imagePath,
   required this.imagUploadTime,
   required this.fontWeight
   });



  @override
  State<ImagesHomePageUserUpaloadCustome> createState() => _ImagesHomePageUserUpaloadCustomeState();
}

class _ImagesHomePageUserUpaloadCustomeState extends State<ImagesHomePageUserUpaloadCustome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            child:
            FadeInImage.assetNetwork(
              placeholder: Assets.Dammyimages,
              image: widget.imagePath,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
             // alignment: Alignment.bottomCenter,
              placeholderFit: BoxFit.cover,
              imageErrorBuilder: (c,o,s) => Image.asset(Assets.ImageNotFound),
              fit: BoxFit.cover,
            ),
            /*Image.network(
              widget.imagePath,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),*/

          ),
          Container(
            margin: EdgeInsets.only(right: 10,bottom: 5),
            alignment: Alignment.bottomRight,

            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                decoration: BoxDecoration(
                    color: AppColors.white,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text(widget.imagUploadTime,style: TextStyle(color: AppColors.black,fontWeight: widget.fontWeight ?? FontWeight.w500),)),
          ),
        ],
      ),
    );
  }
}
