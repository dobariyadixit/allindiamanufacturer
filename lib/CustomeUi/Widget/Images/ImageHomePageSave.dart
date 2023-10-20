import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ImagesProperty/ImagesSize.dart';
import 'package:flutter/material.dart';

class IconsHomePageSave extends StatefulWidget {
  bool? chackFovrite;
   IconsHomePageSave({super.key , required this.chackFovrite});

  @override
  State<IconsHomePageSave> createState() => _IconsHomePageSaveState();
}

class _IconsHomePageSaveState extends State<IconsHomePageSave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Image.asset( widget.chackFovrite == false ?  Assets.HomepadeUnSave : Assets.HomepadeSave,
            height: ImagesSize.Homepage_Save_Height,
            width: ImagesSize.Homepage_Save_Width,
          )),
    );
  }
}
