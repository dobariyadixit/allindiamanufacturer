import 'dart:convert';
import 'dart:io';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/AddFavoritePostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/GetPostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/OtpModel.dart';
import 'package:allindiamanufacturer/ClearImages.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/CustomeButton/CustomeButton.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/PdfView/PdfView.dart';
import 'package:allindiamanufacturer/Screen/NewPostScreen/NewPostScreen.dart';
import 'package:allindiamanufacturer/Screen/ProfileScreen/ProfileScreen.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/LoginModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
//import 'package:allindiamanufacturer/CustomeUi/Widget/Images/ImageHomePageSave.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/Images/ImagesHomePageUserProfileCustome.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/Images/ImagesHomePageUserUpaloadCustome.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/Images/dotImageHomeScreen.dart';
import 'package:allindiamanufacturer/ImagesProperty/ImagesSize.dart';
import 'package:allindiamanufacturer/Screen/AboutCommunityScreen/AboutCommunityScreen.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:allindiamanufacturer/TextProperty/Textsize.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:dio/dio.dart' as d;
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:readmore/readmore.dart';
//import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreference sharedPreference = SharedPreference();

  int currentPageIndex = 0;

  bool? statusLogin;
  String? messageLogin;

  bool? statusOtp;
  String? tokenOtp;
  String? messageOtp;
  String? nameOtp;
  String? imageOtp;
  String? mobileOtp;
  String? userIdOtp;

  bool? statusGetPost;
  String? messageGetPost;
  int? currentPageGetPost;
  int? countGetPost;
  int? perPageGetPost;
  List<GetPostModelData>? ImagesListData = [];
  List<GetPostModelData>? ImagesListData1 = [];

  bool? statusAddFavoritePost;
  String? messageAddFavoritePost;

  final TextEditingController _controller = TextEditingController();

  final mobileNumberControler = TextEditingController();
  final nameControler = TextEditingController();

  final scrollController = ScrollController();

  bool isLoginMore = false;

 /* List<String> _photos = [
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

  void _showPickerMor(context, int chackPage) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text(Textfile.gallery),
                      onTap: () {
                        selectGalleryMor(chackPage);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(Textfile.Camera),
                    onTap: () {
                      imgFromCameraMor(chackPage);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker imagePickerMor = ImagePicker();
  XFile? imageFileListMor;
  PickedFile? pickedImageMor;
  final ImagePicker pickerMor = ImagePicker();

  void selectGalleryMor(int chackPage) async {
    final XFile? selectImages = await imagePickerMor.pickMedia();
    if (selectImages!.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = selectImages;
      setState(() {});
      diallogBoxFun(chackPage);
    }
  }

  imgFromCameraMor(int chackPage) async {
    pickedImageMor = await pickerMor.getImage(source: ImageSource.camera);
    XFile imageMor = XFile(pickedImageMor!.path);
    if (imageMor.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = imageMor;
      setState(() {});
      diallogBoxFun(chackPage);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(_scrollListener);
    getPost();
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
      await getPost();
      setState(() {
        isLoginMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      backgroundColor: AppColors.HomapadeBackGraundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutCommunityScreen(),
                ));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(Textfile.allindiamanufacturr,
                    style: TextStyle(
                        fontSize: TextSize.appBarTitleAllInadiyaManufacturer,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black)),
                Text(Textfile.Members520,
                    style: TextStyle(
                        fontSize: TextSize.appBarTitle520Members,
                        color: AppColors.black)),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("On Refress -----------------");
          apiPageNumber = 1;
          ImagesListData!.clear();
          ImagesListData1!.clear();

          setState(() {
            ImageCache createImageCache() => MyImageCache();
          });
          getPost();
        },
        child: ImagesListData!.isEmpty
            ? Container(
                margin: EdgeInsets.only(bottom: 45),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  controller: scrollController,
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                      padding:
                          EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 4),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            //   width: MediaQuery.of(context).size.width / 1.3,
                            color: AppColors.white,
                            height:
                                ImagesSize.userUpaloadImagesTitleConteinerSize,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      margin: EdgeInsets.only(right: 10),
                                      height:
                                          ImagesSize.HomepageUserProfileHeight,
                                      width:
                                          ImagesSize.HomepageUserProfileWidth,
                                      child: Icon(
                                        Icons.person,
                                        size: 25,
                                      )),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Text(
                                    "User Name",
                                    style: TextStyle(
                                        fontSize:
                                            TextSize.HomeScreenUserNameSize,
                                        color: AppColors.UsernameColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Spacer(),
                                Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                      height: ImagesSize.saveImagsHeight,
                                      width: ImagesSize.saveImagsWidth,
                                      margin: EdgeInsets.only(
                                          top: 3, bottom: 3, right: 5),
                                      child: Image.asset(
                                        "assets/Icons/Save.png",
                                      )),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Container(
                                      height: ImagesSize.saveImagsHeight,
                                      width: ImagesSize.saveImagsWidth,
                                      margin: EdgeInsets.only(
                                          top: 3, bottom: 3, right: 13),
                                      child: Image.asset(Assets.DotIcons)),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              height: MediaQuery.of(context).size.height / 3.5,
                              child: Shimmer.fromColors(
                                  baseColor: Colors.white10,
                                  highlightColor: Colors.grey,
                                  child: Icon(
                                    Icons.image_outlined,
                                    size: 100,
                                  ))),
                        ],
                      ),
                    );
                  },
                ),
              )
            : Container(
                margin: EdgeInsets.only(bottom: 45),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10),
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: isLoginMore ? ImagesListData!.length + 1 : ImagesListData!.length,
                  itemBuilder: (context, index) {
                    if (index < ImagesListData!.length) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        padding: EdgeInsets.only(top: 4, left: 4, right: 4, bottom: 4),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              //   width: MediaQuery.of(context).size.width / 1.3,
                              color: AppColors.white,
                              height: ImagesSize
                                  .userUpaloadImagesTitleConteinerSize,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height:
                                      ImagesSize.HomepageUserProfileHeight,
                                      width:
                                          ImagesSize.HomepageUserProfileWidth,
                                      child: ImagesCustome(
                                        imagePath: ImagesListData![index]
                                            .userImage
                                            .toString(),
                                      )),
                                  Container(
                                    width: MediaQuery.of(context).size.width - 150,
                                    child: Text(
                                      "${ImagesListData![index].businessName}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              TextSize.HomeScreenUserNameSize,
                                          color: AppColors.UsernameColor,
                                         // overflow: TextOverflow.visible,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                      onTap: () async {
                                        bool checkLogin = await sharedPreference.isLoggedIn();

                                        if (checkLogin == true) {
                                          print("Login is True ---------->>>");

                                          addFavoritePost(ImagesListData![index].id.toString() , index);

                                        } else {
                                          print("Login First ---------->>>");
                                          diallogBoxFun(0);
                                        }
                                      },
                                      child: Container(
                                          height: ImagesSize.saveImagsHeight,
                                          width: ImagesSize.saveImagsWidth,
                                          margin: EdgeInsets.only(
                                              top: 3, bottom: 3, right: 5),
                                          child: Image.asset(
                                            ImagesListData![index].isFavorite == false
                                                ? "assets/Icons/unSave.png"
                                                : "assets/Icons/Save.png",
                                          ))),
                                  InkWell(
                                    onTap: () async {

                                      bool checkLogin = await sharedPreference.isLoggedIn();

                                      if (checkLogin == true) {
                                        print("Login is True ---------->>>");

                                      //  getNewDownloads(ImagesListData![index].image,pd);
                                      } else {
                                        print("Login First ---------->>>");
                                        diallogBoxFun(0);
                                      }
                                    },
                                    child: Container(
                                        height: ImagesSize.saveImagsHeight,
                                        width: ImagesSize.saveImagsWidth,
                                        margin: EdgeInsets.only(
                                            top: 3, bottom: 3, right: 13),
                                        child: dotImageHomeScreen()),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                child: ImagesListData![index].type == "image"
                                    ? InkWell(
                                        onTap: () async {
                                          bool checkLogin =
                                              await sharedPreference
                                                  .isLoggedIn();
                                          if (checkLogin == true) {
                                            print(
                                                "Login is True ---------->>>");
                                            imagediallog(
                                                ImagesListData![index]
                                                    .image
                                                    .toString(),
                                                ImagesListData![index]
                                                    .description
                                                    .toString());
                                          } else {
                                            print("Login First ---------->>>");
                                            diallogBoxFun(0);
                                          }
                                        },
                                        child: ImagesHomePageUserUpaloadCustome(
                                          imagePath: ImagesListData![index]
                                              .image
                                              .toString(),
                                          imagUploadTime: ImagesListData![index]
                                              .time
                                              .toString(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          pdfview(
                                              ImagesListData![index]
                                                  .image
                                                  .toString(),
                                              ImagesListData![index]
                                                  .description
                                                  .toString());
                                        },
                                        //  child: Image.asset(Assets.pdfIcon)
                                        child:
                                        InkWell(
                                          onTap: () {
                                            print("details ------->>");
                                           // print("details ------->>$details");
                                            /*    pdfview(
                                                ImagesListData![index].image.toString(),
                                                ImagesListData![index].description.toString());
                                         */
                                          },
                                          child: PdfView(
                                            imagePath: ImagesListData![index].image.toString(),
                                            postTime: ImagesListData![index].time.toString(),
                                            onTep: () {   pdfview(
                                                ImagesListData![index].image.toString(),
                                                ImagesListData![index].description.toString());},),

                                        ),
                                  /*Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: AppColors.white),
                                          //margin: EdgeInsets.only(left: 10, right: 10),
                                          padding: EdgeInsets.all(1),
                                          child: Stack(
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
                                                    onTap: (details) {
                                                      print("details ------->>$details");
                                                      pdfview(
                                                          ImagesListData![index].image.toString(),
                                                          ImagesListData![index].description.toString());
                                                    },
                                                      enableDoubleTapZooming: false,
                                                      maxZoomLevel: 1,
                                                      initialZoomLevel: 1,
                                                      ImagesListData![index].image.toString())
                                              ),
                                              Container(
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
                                                child: Text(
                                                  ImagesListData![index]
                                                      .time
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),*/
                                    ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                             Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 5,),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width- 70,
                                    child: ReadMoreText(
                                     // 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                                      ImagesListData![index].description,
                                      trimLines: 2,
                                      colorClickableText: Colors.pink,
                                      trimMode: TrimMode.Line,
                                      trimCollapsedText: '  Show more..',
                                      trimExpandedText: '  Show less',
                                      moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),
                                      lessStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),

                                    ),
                                    ),
                                SizedBox(width: 5,),
                                InkWell(
                                  onTap: () async {
                                    bool checkLogin = await sharedPreference.isLoggedIn();

                                    if (checkLogin == true) {
                                      print("Login is True ---------->>>");

                                      getNewDownloads(ImagesListData![index].image,pd);

                                    }
                                    else
                                    {
                                      print("Login First ---------->>>");
                                      diallogBoxFun(0);
                                    }

                                  },
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Icon(Icons.download))),
                                SizedBox(width: 5,),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                      else {
                        return Container(
                          height: MediaQuery.of(context).size.height / 13,
                          alignment: Alignment.center,
                          child: CupertinoActivityIndicator(
                              radius: 20.0, color: CupertinoColors.activeBlue),
                        );
                      }
                  },
                ),
              ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                bool checkLogin = await sharedPreference.isLoggedIn();

                if (checkLogin == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPostScreen(),
                      ));
                } else {
                  diallogBoxFun(1);
                }
              },
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Image.asset(Assets.HomepadeSpiker),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 5,
            ),
            InkWell(
              onTap: () async {
                bool checkLogin = await sharedPreference.isLoggedIn();
                if (checkLogin == true) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ));
                } else {
                  diallogBoxFun(2);
                }
              },
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(10.5),
                child: Container(
                  child: Image.asset(Assets.HomepadePerson),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int textMaxLine = 1;

  imagediallog(String imagesPath, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                 //   child: Image.network(imagesPath),
                    child: FadeInImage.assetNetwork(
                      placeholder: Assets.Dammyimages,
                      placeholderFit: BoxFit.cover,
                      image: imagesPath,
                      imageErrorBuilder: (c,o,s) => Image.asset(Assets.ImageNotFound),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      description,
                     // maxLines: textMaxLine,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black),
                    ),
                  ),
            /*      Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Text(
                      "Read More...",
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 17,
                          color: AppColors
                              .blue,fontWeight: FontWeight.w500),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  pdfview(String pdfLink, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content : SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white),
             // margin: EdgeInsets.only(left: 3, right: 3),
             // padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: SfPdfViewer.network(pdfLink)),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  diallogBoxFun(int chackPage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              //   actionsAlignment: MainAxisAlignment.end,
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.only(left: 10, right: 10),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              title: Center(
                  child: Text(
                Textfile.LOGIN,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              )),
              content: SingleChildScrollView(
                child: Container(
                  //  height: MediaQuery.of(context).size.height / 2.2,
                  //  height: 308,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      //mobile no
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        margin: EdgeInsets.only(bottom: 10, top: 15),
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Container(
                          height: 20,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: mobileNumberControler,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              hintText: Textfile.MobieNo,
                            ),
                          ),
                        ),
                      ),
                      // round part
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _showPickerMor(context, chackPage);
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      width: 1.5, color: AppColors.black)),
                              child: imageFileListMor == null
                                  ? Icon(
                                      Icons.image,
                                      color: AppColors.blackShade3,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: Container(
                                        child: Image.file(
                                          File(imageFileListMor!.path),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 140,
                            margin: EdgeInsets.only(left: 5,),
                            child: TextField(
                              controller: nameControler,
                              //  textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: Textfile.BrandNameAndBussinesNameHint,
                                hintStyle: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 0.5,
                        color: AppColors.black,
                      ),
                      // line

                      //submit button
                      CustomeButton(
                        onTap: () {
                          if (mobileNumberControler.text.isNotEmpty) {
                            if (nameControler.text.isNotEmpty) {
                              loginApi(nameControler.text,
                                  mobileNumberControler.text);
                            } else {
                              Fluttertoast.showToast(
                                  msg: Textfile.PleaseEnternmae,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: Textfile.PleaseEnterMobileNumber,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        BorderRadiuss: 30,
                        TopMargin: 12,
                        ButtonName: Textfile.Submit,
                        BorderColor: AppColors.NewPost,
                        ButtonColor: AppColors.ButtoneColor,
                        ButtonWidth: MediaQuery.of(context).size.width / 3,
                        ButtonHeight: 35,
                      ),
                      //otp
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        Textfile.OTP,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      //otp box
                      Container(
                        // width: MediaQuery.of(context).size.width / 2.2,
                        width: 175,
                        child: darkRoundedPinPut(),
                      ),
                      CustomeButton(
                        onTap: () {
                          if (mobileNumberControler.text.isNotEmpty) {
                            if (_controller.text.isNotEmpty) {
                              if (_controller.text.length == 4) {
                                otpApi(mobileNumberControler.text,
                                    _controller.text, chackPage);
                              } else {
                                Fluttertoast.showToast(
                                    msg: Textfile.PleaseEnterValidOtp,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: Textfile.Pleaseenteryourotp,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          } else {
                            Fluttertoast.showToast(
                                msg: Textfile.PleaseEnterMobileNumber,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        BorderRadiuss: 30,
                        TopMargin: 12,
                        ButtonName: Textfile.Enter,
                        BorderColor: AppColors.NewPost,
                        ButtonColor: AppColors.ButtoneColor,
                        ButtonWidth: MediaQuery.of(context).size.width / 3,
                        ButtonHeight: 35,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  darkRoundedPinPut() {
    return PinPut(
      eachFieldWidth: 1,
      eachFieldHeight: 1,
      withCursor: true,
      fieldsCount: 4,
      controller: _controller,
      onSubmit: (String pin) => _showSnackBar(pin),
      submittedFieldDecoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(0),
      ),
      selectedFieldDecoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(0),
      ),
      followingFieldDecoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(0),
      ),
      pinAnimationType: PinAnimationType.rotation,
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          height: 1,
          fontWeight: FontWeight.bold),
    );
  }

  void _showSnackBar(String pin) {
    print("pin ------------------>> $pin");
    print("pin Controler ------------------>> ${_controller.text}");
    final snackBar = SnackBar(
      duration: Duration(seconds: 4),
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted: $pin',
            style: TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Colors.green,
    );
  }

  Future<d.Response> loginApi(String name, String mobileNumber) async {
    String url = ApiUrl.loginApi;
    try {
      d.FormData formData = d.FormData();

      if (imageFileListMor != null) {
        File file = new File.fromUri(Uri.parse(imageFileListMor!.path));
        formData.files.add(
          MapEntry(
            "image",
            d.MultipartFile.fromFileSync(file.path, filename: file.path),
          ),
        );
      } else {
        print("======>> Images is Ematy <<======");
      }

      print("===>==>==>  name => ${name}");
      print("==>==>==> mobile ==> ${mobileNumber}");

      formData.fields.add(MapEntry('name', name));
      formData.fields.add(MapEntry('mobile', mobileNumber));

      d.Response response;
      print(url);

      d.Dio dio = d.Dio();

      response = await dio.post(url,
          data: formData,
          options: Options(
            followRedirects: false,
            headers: {"Accept": "application/json"},
            validateStatus: (status) => true,
          ));
      //pd.close();
      print('Response request: ${response.requestOptions}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      print("-------------->>>>>>> Login Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.data}");

      if (response.statusCode == 200) {
        LoginModel loginmodel = LoginModel.fromJson(response.data);

        statusLogin = loginmodel.status;
        messageLogin = loginmodel.message;

        print("StatusLogin --------------> $statusLogin");
        print("MessageLogin --------------> $messageLogin");

        if (statusLogin == true) {
          Fluttertoast.showToast(
              msg: messageLogin.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          print("Login Status Is ----->> $statusLogin");
        }
      } else {
        print("Login Api Reponce is -------------->> ${response.statusCode}");
      }
      return response;
    } catch (e) {
      print("exception" + e.toString());
      // hideLoader();
      //pd.close();
      return d.Response(requestOptions: RequestOptions(path: url));
    }
  }

  otpApi(String mobileNumber, String otp, int chackPage,) async {
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.OtpApi),
        headers: {"Accept": "application/json"},
        body: {
          "mobile": "$mobileNumber",
          "otp": "$otp",
        },
      );

      OtpModel otpModel = OtpModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Login Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusOtp = otpModel.status;
        messageOtp = otpModel.message;
        tokenOtp = otpModel.token;
        nameOtp = otpModel.data!.name;
        imageOtp = otpModel.data!.image;
        mobileOtp = otpModel.data!.mobile;
        userIdOtp = otpModel.data!.id.toString();

        print("StatusOtp --------------> $statusOtp");
        print("MessageOtp --------------> $messageOtp");
        print("TokenOtp --------------> $tokenOtp");
        print("NameOtp --------------> $nameOtp");
        print("MobileOtp --------------> $mobileOtp");
        print("userIdOtp --------------> $userIdOtp");

        if (statusOtp == true) {
          Fluttertoast.showToast(
              msg: Textfile.SuccessfullyLogin,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          sharedPreference.setLoggedIn(true);
          sharedPreference.settoken(tokenOtp!);
          sharedPreference.setuserName(nameOtp!);
          sharedPreference.setmobileNumber(mobileOtp!);
          sharedPreference.setuserId(userIdOtp!);

          Navigator.pop(context);
          chackPage == 1
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPostScreen(),
                  ))
              : chackPage == 2
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ))
                  : '';
          // Navigator.pop(context);
        } else {
          print("Otp Status is $statusOtp");
        }
      } else {
        print("Login Api Responce is =====>>>> ${response.statusCode}");
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
    }
  }

  getPost() async {
    bool chackLogin;
    String userId;

    chackLogin = await sharedPreference.isLoggedIn();
    userId = await sharedPreference.isuserId();

    print("Login Chack --> $chackLogin");
    print("userId Chack --> $userId");

    String apiUrl = ApiUrl.all_post + "$apiPageNumber" + "&user_id=$userId";

   // chackLogin == false ? apiUrl : apiUrl + "&user_id=$userId";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {"Accept": "application/json"},
      );

      GetPostModel getPostModel =
          GetPostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Get Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        print("getPostModel status --------------> $getPostModel.status");
        print("statusGetPost --------------> $statusGetPost");

        statusGetPost = getPostModel.status;

        if (statusGetPost == true) {
          messageGetPost = getPostModel.message;
          ImagesListData1 = getPostModel.data;
          currentPageGetPost = getPostModel.currentPage;
          countGetPost = getPostModel.count;
          perPageGetPost = getPostModel.perPage;

          ImagesListData!.addAll(ImagesListData1!);

          print("message GetPost --------------> $messageGetPost");
          print("currentPage GetPost --------------> $currentPageGetPost");
          print("count GetPost --------------> $countGetPost");
          print("perPage GetPost --------------> $perPageGetPost");
          print(
              "ImagesListData1 length --------------> ${ImagesListData1!.length}");
          print(
              "ImagesListData length --------------> ${ImagesListData!.length}");
          setState(() {});
        } else {
          print("Get Post Status is $statusOtp");
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

  Future<AddFavoritePostModel?> addFavoritePost(String postId , int arrayindex ) async {

    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    String UserLoginToken;

    UserLoginToken = await sharedPreference.istoken();
    print("User Login Token ====> $UserLoginToken");

    try {
      final response = await http.post(Uri.parse(ApiUrl.AddFavoritePost),
          //  Uri.parse("https://marketing.parivartanacademy.org.in/api/add_favorite_post"),

          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $UserLoginToken",
          },
          body: {
            "post_id": "$postId"
          });

      AddFavoritePostModel addFavoritePostModel =
          AddFavoritePostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Add Favorite Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusAddFavoritePost = addFavoritePostModel.status;
        messageAddFavoritePost = addFavoritePostModel.message;

        print("statusAddFavoritePost --------------> $statusAddFavoritePost");
        print("messageAddFavoritePost --------------> $messageAddFavoritePost");

        if (statusGetPost == true) {
          Navigator.pop(context);
          ImagesListData![arrayindex].isFavorite = true;
          setState(() {});
          Fluttertoast.showToast(
              msg: messageAddFavoritePost.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Navigator.pop(context);
          print("Add Favorite Post Status is $statusOtp");
        }
      }
      else {
        Navigator.pop(context);
        print(
            "Add Favorite Post Api Responce is =====>>>> ${response.statusCode}");
        setState(() {});
      }
    } catch (e) {
      Navigator.pop(context);
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
      setState(() {});
    }
  }

  getNewDownloads(String fileurl,ProgressDialog pd){
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    File file = File(fileurl);
    String fileName = file.path.split(Platform.pathSeparator).last; // my_image.jpg
    //You can download a single file
    FileDownloader.downloadFile(
        url: fileurl,
        name: fileName, //THE FILE NAME AFTER DOWNLOADING,
        onProgress: (String? fileName, double progress){
          int abd=int.parse(progress.toString());
          pd.show(max: abd,msg: "Please Wait");
          pd.update(value: abd,msg: "Please Wait");
          print('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
         Navigator.pop(context);
          print('FILE DOWNLOADED TO PATH: $path');
          Fluttertoast.showToast(msg: "Download successfully!");
        },
        onDownloadError: (String error) {
          Navigator.pop(context);
          print('DOWNLOAD ERROR: $error');
        });
  }


}
