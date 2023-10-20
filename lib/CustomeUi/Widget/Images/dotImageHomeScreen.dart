import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:flutter/material.dart';

class dotImageHomeScreen extends StatefulWidget {

 // VoidCallback onTap;

   dotImageHomeScreen({super.key , /*required this.onTap*/});

  @override
  State<dotImageHomeScreen> createState() => _dotImageHomeScreenState();
}

class _dotImageHomeScreenState extends State<dotImageHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
       // onTap: widget.onTap,
        child: Container(
          color: AppColors.white,
          alignment: Alignment.bottomRight,
          child: Image.asset(Assets.HomepadeDot),
        ),
      ),
    );
  }
}
