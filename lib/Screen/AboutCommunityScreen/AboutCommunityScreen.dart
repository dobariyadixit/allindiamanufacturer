import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/AllUSerListModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:allindiamanufacturer/TextProperty/Textsize.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AboutCommunityScreen extends StatefulWidget {
  const AboutCommunityScreen({super.key});

  @override
  State<AboutCommunityScreen> createState() => _AboutCommunityScreenState();
}

class _AboutCommunityScreenState extends State<AboutCommunityScreen> {
  /*List<String> _photos = [
    "${Assets.a1}",
    "${Assets.a2}",
    "${Assets.a3}",
    "${Assets.a4}",
    "${Assets.a5}",
    "${Assets.a6}",
    "${Assets.a7}",
    "${Assets.a8}",
    "${Assets.a9}",
    "${Assets.a10}",
    "${Assets.a1}",
    "${Assets.a2}",
    "${Assets.a3}",
    "${Assets.a4}",
    "${Assets.a5}",
    "${Assets.a6}",
    "${Assets.a7}",
    "${Assets.a8}",
    "${Assets.a9}",
    "${Assets.a10}",
  ];*/

  bool? status;
  String? message;
  int? currentPage;
  int? count;
  int? perPage;
  List<AllUSerListModelData>? allUSerListModelDatList = [];
  List<AllUSerListModelData>? allUSerListModelDatList1 = [];

  bool isLoginMore = false;
  final scrollController = ScrollController();

  SharedPreference sharedPreference = SharedPreference();

  getUser() async {
    String userLoginToken;

    userLoginToken = await sharedPreference.istoken();
    print("User Login Token ====> $userLoginToken");

    try {
      final response = await http.get(
        //  Uri.parse(ApiUrl.AllUserApi + "1"),
        Uri.parse("${ApiUrl.AllUserApi + apiPageNumber.toString()}"),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $userLoginToken",
        },
      );

      AllUSerListModel allUSerListModel =
          AllUSerListModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Get Post Api Responce --->> ${response.statusCode}");
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        print("getPostModel status --------------> ${allUSerListModel.status}");
        print("statusGetPost --------------> $allUSerListModel");

        status = allUSerListModel.status;

        if (status == true) {
          message = allUSerListModel.message;
          currentPage = allUSerListModel.currentPage;
          count = allUSerListModel.count;
          perPage = allUSerListModel.perPage;

          allUSerListModelDatList1 = allUSerListModel.data;
          allUSerListModelDatList!.addAll(allUSerListModelDatList1!);

          print("message  --------------> $message");
          print("currentPage t --------------> $currentPage");
          print("count  --------------> $count");
          print("perPage  --------------> $perPage");
          print(
              "allUSerListModelDatList1 --------------> $allUSerListModelDatList1");
          print(
              "allUSerListModelDatList --------------> $allUSerListModelDatList");
          setState(() {});
        } else {
          print("Get Post Status is $status");
          setState(() {});
        }
      } else {
        print("Get Post Api Responce is =====>>>> ${response.statusCode}");
        setState(() {});
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.appbararrowColor, //change your color here
        ),
        backgroundColor: AppColors.NewPost,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Textfile.allindiamanufacturr,
              style: TextStyle(
                  fontSize: TextSize.appBarTitleAllInadiyaManufacturer,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black),
            ),
            Text(
              Textfile.Members520,
              style: TextStyle(
                  fontSize: TextSize.appBarTitle520Members,
                  color: AppColors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                ),
                child: Text(
                  Textfile.AboutCommunity,
                  style: TextStyle(
                    fontSize: TextSize.AboutCommunity,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                Textfile.aboutCommunityBodyText,
                style: TextStyle(
                  fontSize: TextSize.aboutCommunityBodyText,
                ),
                //  textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 0.5,
              color: AppColors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            allUSerListModelDatList!.length == 0
                ? Container(
                    child: ListView.builder(
                      itemCount: 100,
                   //   controller: scrollController,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 15),
                          child: Row(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                            color: AppColors.black, width: 1)),
                                    child: Icon(
                                      Icons.image,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Text("User Name"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                  height: MediaQuery.of(context).size.height / 1.1,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: isLoginMore ? allUSerListModelDatList!.length + 1 : allUSerListModelDatList!.length,

                  //  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (index < allUSerListModelDatList!.length) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 15),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 0.5, color: Colors.black38)),
                                height: 60,
                                width: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(75),
                                  child: Image.network(
                                    allUSerListModelDatList![index]
                                        .image
                                        .toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(allUSerListModelDatList![index]
                                    .businessName
                                    .toString()),
                              )
                            ],
                          ),
                        );
                      }
                      else {
                        return Container(
                          height: MediaQuery.of(context).size.height / 13,
                          alignment: Alignment.center,
                          child: const CupertinoActivityIndicator(
                              radius: 20.0, color: CupertinoColors.activeBlue),
                        );
                      }
                    },
                  ),
                )
          ],
        ),
      ),

    );
  }

  int apiPageNumber = 1;

  //int descriptionLine;

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      setState(() {
        isLoginMore = true;
      });

      apiPageNumber = apiPageNumber + 1;
      print("api page Number ------------------------------> $apiPageNumber");
      print("Scroll Listenr Called");
      await getUser();
      setState(() {
        isLoginMore = false;
      });
    }
  }
}
