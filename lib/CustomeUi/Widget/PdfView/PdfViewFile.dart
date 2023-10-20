import 'dart:io';

import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewFile extends StatelessWidget {

  File imagePath;
  String postTime;
  VoidCallback onTep;
  double? pdfHeight;
  double? pfdWidth;

  PdfViewFile({
     super.key ,
     required this.imagePath,
     required this.postTime,
     required this.onTep,
     this.pdfHeight,
     this.pfdWidth,
   });

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: AppColors.green),
              height: pdfHeight ?? MediaQuery.of(context).size.height / 3.6,
              width: pfdWidth ?? MediaQuery.of(context).size.width,
              child:
              SfPdfViewer.file(
                  onTap: (details) => onTep(),
                //  enableDoubleTapZooming: false,
                 // maxZoomLevel: 1,
                 // initialZoomLevel: 1,
                  imagePath,
              ),
          ),
        ],
      ),
    );
  }
}

