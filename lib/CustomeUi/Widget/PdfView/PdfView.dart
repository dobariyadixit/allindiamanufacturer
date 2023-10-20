import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatelessWidget {

  String imagePath;
  String postTime;
  VoidCallback onTep;

   PdfView({
     super.key ,
     required this.imagePath,
     required this.postTime,
     required this.onTep,

   });

  @override

  Widget build(BuildContext context) {
    return Scaffold(
     /* body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SfPdfViewer.network(
            onTap: (details) {

            },
            enableDoubleTapZooming: false,
            maxZoomLevel: 1,
            initialZoomLevel: 1,
            imagePath
        ),
      ),*/
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: AppColors.green),
              height: MediaQuery.of(context)
                  .size
                  .height /
                  3.6,
              child:
              SfPdfViewer.network(
                  onTap: (details) => onTep(),
                  enableDoubleTapZooming: false,
                  maxZoomLevel: 1,
                  initialZoomLevel: 1,
                  imagePath,
              ),
          ),


          postTime == "" ? Text("") :Container(
            margin: EdgeInsets.only(
                right: 10, bottom: 5),
            alignment:
            Alignment.bottomRight,
            width: MediaQuery.of(context)
                .size
                .width,
            height: MediaQuery.of(context)
                .size
                .height,
            child: Container(
              padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Text(
                postTime,
                style: TextStyle(
                  color: AppColors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
