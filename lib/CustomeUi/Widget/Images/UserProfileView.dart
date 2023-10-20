import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:flutter/material.dart';

class UserProfileView extends StatelessWidget {

  String imageUserProfileLogo;

  UserProfileView({
     super.key,
required this.imageUserProfileLogo,
   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    /* body : Row(
        mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           margin: EdgeInsets.only(top: 40.0,),
           decoration: BoxDecoration(
             color: AppColors.white,
           ),
           alignment: Alignment.center,
           child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child:
              FadeInImage.assetNetwork(
                placeholder: Assets.Dammyimages,
                image: "https://marketing.parivartanacademy.org.in/uploads/profile/${imageUserProfileLogo}",
                imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                fit: BoxFit.cover,
              ),
              */
      /*widget.userProfileLogo.isEmpty ? Icon(Icons.person) : Image.network("https://marketing.parivartanacademy.org.in/uploads/profile/${widget.userProfileLogo}",fit: BoxFit.cover,),*//*
            ),
         ),
       ],
     ),*/
      body:  Container(
        //height: 120,
       // width: 120,,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
         // color: Colors.amberAccent,
          boxShadow: [
            new BoxShadow(
              color: Colors.deepOrangeAccent,
              blurRadius: 5.0,
            ),
          ],
        ),
        child:
        ClipRRect(
          borderRadius: BorderRadius.circular(75),
          child:
          FadeInImage.assetNetwork(
            placeholder: Assets.Dammyimages,
            image: "https://marketing.parivartanacademy.org.in/uploads/profile/${imageUserProfileLogo}",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
            fit: BoxFit.cover,
          ),
          /*widget.userProfileLogo.isEmpty ? Icon(Icons.person) : Image.network("https://marketing.parivartanacademy.org.in/uploads/profile/${widget.userProfileLogo}",fit: BoxFit.cover,),*/
        ),
      ),
    );
  }
}
