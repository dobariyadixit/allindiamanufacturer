import 'dart:async';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/Screen/HomePage/HomePage.dart';
import 'package:flutter/material.dart';

import '../../ApiServices/ApiModelClass/AdddevicetokenModel.dart';
import '../../ApiServices/ApiUrl/ApiUrl.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPost();

  }

  getPost() async {

    final fcmToken = await FirebaseMessaging.instance.getToken();

    try {
      print("fcmToken===================>"+fcmToken!);
      final response = await http.post(
        Uri.parse(ApiUrl.UploadFireBaseToken),
        body: {
          "device_token":""+fcmToken!,
        },
        headers: {"Accept": "application/json"},
      );

      AdddevicetokenModel getPostModel = AdddevicetokenModel.fromJson(
          jsonDecode(response.body));

      print("-------------->>>>>>> Get Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        print("getPostModel status --------------> $getPostModel.status");
       // print("statusGetPost --------------> $statusGetPost");
        Timer(
          Duration(seconds: 2),
              () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
          },
        );
        // statusGetPost = getPostModel.status;
        //
        //
        // if (statusGetPost == true) {
        //   messageGetPost = getPostModel.message;
        //   ImagesListData1 = getPostModel.data;
        //   currentPageGetPost = getPostModel.currentPage;
        //   countGetPost = getPostModel.count;
        //   perPageGetPost = getPostModel.perPage;
        //
        //
        //   ImagesListData!.addAll(ImagesListData1!);
        //
        //
        //   print("message GetPost --------------> $messageGetPost");
        //   print("currentPage GetPost --------------> $currentPageGetPost");
        //   print("count GetPost --------------> $countGetPost");
        //   print("perPage GetPost --------------> $perPageGetPost");
        //   print("ImagesListData1 --------------> $ImagesListData1");
        //   print("ImagesListData --------------> $ImagesListData");
        //   setState(() {
        //
        //   });
        // }
        // else {
        //   print("Get Post Status is $statusOtp");
        //   setState(() {
        //
        //   });
        // }setState
      }
      else {
        print("Get Post Api Responce is =====>>>> ${response.statusCode}");
        setState(() {

        });
      }
    }
    catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Assets.AppLoga,
          width: MediaQuery.of(context).size.width / 3.5,
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height / 7,
       // width: MediaQuery.of(context).size.width / 2,
        child:Image.asset(
          Assets.AppNameLoga,
          width: MediaQuery.of(context).size.width / 2.4,

        ),
      ),
    );
  }
}
