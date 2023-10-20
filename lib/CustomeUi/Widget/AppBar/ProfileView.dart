
import 'package:flutter/material.dart';

import '../../../Assets/AssetsScreen.dart';

class ProfileView extends StatefulWidget {

  String userProfileLogo;
  ProfileView({
    required this.userProfileLogo,
  });
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 40.0,),
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amberAccent,
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
                      Image.network(widget.userProfileLogo,
                        fit: BoxFit.cover,
                        // placeholder: Assets.Dammyimages,
                        errorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                        //  imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                      ),
                  /*    FadeInImage.assetNetwork(
                        placeholder: Assets.Dammyimages,
                        image: widget.userProfileLogo,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                        fit: BoxFit.cover,
                      ),*/

                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 95, left: 85),
                    height: 25,
                    width: 25,
                    child: Icon(
                      Icons.cached_sharp,
                      color: Colors.red.shade500,
                      size: 20,
                    ),
                    //   color: Colors.blue,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}
