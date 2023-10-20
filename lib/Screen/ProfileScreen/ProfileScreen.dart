import 'dart:convert';
import 'dart:io';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/EditPostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/UpdateProfileLogoModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/UserProfilePhotoModel.dart';
import 'package:allindiamanufacturer/ClearImages.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/CustomeButton/CustomeButton.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/Images/UserProfileView.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/PdfView/PdfView.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/PdfView/PdfViewFile.dart';
import 'package:allindiamanufacturer/Screen/UpadetProfileDetailsScreen/UpadetProfileDetailsScreen.dart';
import 'package:allindiamanufacturer/Screen/UserDetailsScreen/UserDetailsScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/DeletePostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/GetFavoritePostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/GetUserUploadPostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:allindiamanufacturer/Screen/NewPostScreen/NewPostScreen.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:allindiamanufacturer/TextProperty/Textsize.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as d;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../CustomeUi/Widget/AppBar/ProfileView.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int validator = 1;

  TextEditingController title = TextEditingController();
  TextEditingController decripaction = TextEditingController();

  String? documentType = "";

  SharedPreference sharedPreference = SharedPreference();

  void _showPickerMor(
    context,
    String postId,
    String description,
    String imagePath,
  ) {
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
                        // Navigator.pop(context);

                        selectGalleryMor(
                          postId.toString(),
                          description,
                          imagePath,
                        );
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(Textfile.Camera),
                    onTap: () {
                      //   Navigator.pop(context);

                      imgFromCameraMor(
                        postId.toString(),
                        description,
                        imagePath,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  final ImagePicker imagePickerMor = ImagePicker();
  File? imageFileListMor;
  PickedFile? pickedImageMor;
  final ImagePicker pickerMor = ImagePicker();

  void selectGalleryMor(
    String postId,
    String description,
    String imagePath,
  ) async {
    Navigator.pop(context);
    final XFile? selectImages = await imagePickerMor.pickMedia();
    if (selectImages!.path.isNotEmpty) {
      imageFileListMor = null;
      File file = File(selectImages.path);
      imageFileListMor = file;
      setState(() {});
      EditImagediallog(
        postId.toString(),
        description,
        imagePath,
      );

      imageFileListMor!.path.substring((imageFileListMor!.path.length - 4)
                  .clamp(0, imageFileListMor!.path.length)) ==
              ".pdf"
          ? documentType = "pdf"
          : documentType = "image";
    }
  }

  imgFromCameraMor(
    String postId,
    String description,
    String imagePath,) async {
    Navigator.pop(context);
    pickedImageMor = await pickerMor.getImage(source: ImageSource.camera);
    File imageMor = File(pickedImageMor!.path);
    if (imageMor!.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = imageMor;
      setState(() {});
      EditImagediallog(
        postId.toString(),
        description,
        imagePath,
      );

      imageFileListMor!.path.substring((imageFileListMor!.path.length - 4)
                  .clamp(0, imageFileListMor!.path.length)) ==
              ".pdf"
          ? documentType = "pdf"
          : documentType = "image";
    }
  }

  upadetProfilePhoto(String imagesPath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: AppColors.white,
              insetPadding: EdgeInsets.only(left: 10, right: 10),
              content: Container(
                //  width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white),
                // color: AppColors.greyShade1),
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        child: Image.file(
                          File(imageFileListMor!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Text(
                        "Are You Sure To Update Your Profile Picture ?",
                        style: TextStyle(
                            fontSize: 15,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomeButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          ButtonName: "No",
                          ButtonColor: AppColors.ButtoneColor,
                          ButtonHeight: 35,
                          ButtonWidth: 100,
                          BorderRadiuss: 50,
                          TextFontWeight: FontWeight.w600,
                        ),
                        CustomeButton(
                          onTap: () {
                            uploadProfileLogo(imageFileListMor!.path);
                            Navigator.pop(context);
                          },
                          ButtonName: "Yes",
                          ButtonColor: AppColors.ButtoneColor,
                          ButtonHeight: 35,
                          ButtonWidth: 100,
                          BorderRadiuss: 50,
                          TextFontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      ImageCache createImageCache() => MyImageCache();
    });
    _tabController = TabController(length: 2, vsync: this);

    scrollControllerFavritePost.addListener(_scrollListener);
    scrollControllerUserPost.addListener(_scrollListenerUserPost);

    getFavoritePostApi();
    getUSerUploadPostApi();
    getTokans();
  }

  String? token;

  bool? statusgetFavoritePost;
  String? messagegetFavoritePost;
  List<GetFavoritePostModelData>? priflleImagesListData = [];
  List<GetFavoritePostModelData>? priflleImagesListData1 = [];

  bool? statusDeletePost;
  String? messageDeletePost;

  bool? statusEditPost;
  String? messageEditPost;

  bool? statusUserUpaloadPost;
  String? messageUserUpaloadPost;
  int? currentPageUserUpaloadPost;
  int? countUserUpaloadPost;
  int? perPageUserUpaloadPost;
  List<GetUserUploadPostModelData>? UserUploadDataList = [];
  List<GetUserUploadPostModelData>? UserUploadDataList1 = [];

  bool? statusUserProfileLogo;
  String? messageUserProfileLogo;
  int? idUserProfileLogo;
  String? nameUserProfileLogo = "";
  String? imageUserProfileLogo;
  String? mobileUserProfileLogo;
  String? createdAtUserProfileLogo;
  String? updatedAtUserProfileLogo;

  bool? statusUploadProfilePhoto = false;
  String? messageUploadProfilePhoto = "";

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
    "${Assets.a8}",
    "${Assets.a9}",
    "${Assets.a8}",
  ];*/

  int currentPageIndex = 0;

  bool isFavriteLoginMore = false;
  bool isUserLoginMore = false;


  final scrollControllerFavritePost = ScrollController();
  final scrollControllerUserPost = ScrollController();

  int favroteApiPageNumber = 1;
  int userPostApiPageNumber = 1;

  Future<void> _scrollListener() async {
    if (scrollControllerFavritePost.position.pixels ==
        scrollControllerFavritePost.position.maxScrollExtent) {
      setState(() {
        isFavriteLoginMore = true;
      });

      favroteApiPageNumber = favroteApiPageNumber + 1;
      print(
          "api page Number ------------------------------> $favroteApiPageNumber");
      print("Scroll Listenr Called");
      await getFavoritePostApi();
      setState(() {
        isFavriteLoginMore = false;
      });
    }
  }

  Future<void> _scrollListenerUserPost() async {
    if (scrollControllerUserPost.position.pixels ==
        scrollControllerUserPost.position.maxScrollExtent) {
      setState(() {
        isUserLoginMore = true;
      });

      userPostApiPageNumber = userPostApiPageNumber + 1;
      print(
          "api page Number ------------------------------> $userPostApiPageNumber");
      print("Scroll Listenr Called");
      await getUSerUploadPostApi();
      setState(() {
        isUserLoginMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //  getTokans();
    print("nameUserProfileLogo ====== >" + nameUserProfileLogo!);
    return Scaffold(
      backgroundColor: AppColors.white,
      // extendBody: true,
      body: DefaultTabController(
        length: _tabController!.length,
        child: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                collapsedHeight: 220,
                expandedHeight: 180,
                flexibleSpace: InkWell(
                  onTap: () {
                    //   _showPickerMor(context);
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => UpadetProfileDetailsScreen(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsScreen(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ProfileView(
                        userProfileLogo: imageUserProfileLogo.toString(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, right: 10, left: 10),
                        alignment: Alignment.center,
                        child: Text(
                          nameUserProfileLogo == ""
                              ? "Business Name"
                              : nameUserProfileLogo!.toString(),
                          overflow: TextOverflow.ellipsis,
                          // Textfile.UserNameProfile,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: TextSize.UserNameProfile),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                floating: true,
                delegate: _SliverAppBarTabDelegate(
                  child: PreferredSize(
                    // preferredSize: Size.fromHeight(100),
                    preferredSize: Size.fromHeight(125),
                    child: Container(
                      //   height: 150,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Colors.grey,
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Colors.black,
                            isScrollable: false,
                            indicatorPadding: EdgeInsets.only(
                                left: 40, right: 40, top: 4, bottom: 4),
                            indicator: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.shade300,
                            ),
                            tabs: [
                              Image.asset(
                                Assets.HomepadeSpiker,
                                height: 25,
                                width: 25,
                              ),
                              Container(
                                  height: 40,
                                  width: 130,
                                  child: Icon(Icons.turned_in)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10, left: 10),
                            decoration: BoxDecoration(
                                color: AppColors.black,
                                borderRadius: BorderRadius.circular(2)),
                            width: double.infinity,
                            height: 0.8,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              UserUploadDataList!.length == 0
                  ? Container(
                      height: MediaQuery.of(context).size.height + 100,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 50),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8.0,
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            child: Shimmer.fromColors(
                              baseColor: Colors.white10,
                              highlightColor: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.black, width: 1)),
                                child: Icon(
                                  Icons.image,
                                  size: 35,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height + 100,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 50),
                      child: GridView.builder(

                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8.0,
                            crossAxisCount: 3,
                            crossAxisSpacing: 8),
                    //    itemCount: UserUploadDataList!.length,
                        itemCount: isUserLoginMore ? UserUploadDataList!.length + 3 : UserUploadDataList!.length,
                        itemBuilder: (context, index) {
                          validator = 0;
                          print(_tabController!.index);

                          if (index < priflleImagesListData!.length) {
                          return InkWell(
                            onTap: () {
                              decripaction.text = UserUploadDataList![index].description.toString();


                                UserUploadDataList![index].type == "pdf" ?

                        myPdfdialog(  UserUploadDataList![index].image.toString(),
                            UserUploadDataList![index].description.toString(),
                            UserUploadDataList![index].id,
                            index,
                            "pdf",
                        )
                            :
                        imagediallog(
                            UserUploadDataList![index].image.toString(),
                            UserUploadDataList![index].description.toString(),
                            UserUploadDataList![index].id,
                            index,
                          "image"
                          //   priflleImagesListData![index].description.toString(),
                        );
                            },
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: UserUploadDataList![index].type == "pdf"
                                    ? PdfView(
                                        imagePath: UserUploadDataList![index]
                                            .image
                                            .toString(),
                                        postTime: "",
                                        onTep: () {
                                          decripaction.text =
                                              UserUploadDataList![index]
                                                  .description
                                                  .toString();
                                          myPdfdialog(
                                            UserUploadDataList![index].image.toString(),
                                            UserUploadDataList![index].description.toString(),
                                            UserUploadDataList![index].id,
                                            index,
                                            "pdf",
                                          );
                                        },
                                        //  onTep: () {}
                                      )
                                    : InkWell(
                                        onTap: () {
                                          decripaction.text =
                                              UserUploadDataList![index]
                                                  .description
                                                  .toString();
                                          imagediallog(
                                              UserUploadDataList![index]
                                                  .image
                                                  .toString(),
                                              UserUploadDataList![index]
                                                  .description
                                                  .toString(),
                                              UserUploadDataList![index].id,
                                              index,
                                              "image"
                                              //   priflleImagesListData![index].description.toString(),
                                              );
                                        },
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Assets.Dammyimages,
                                          image: UserUploadDataList![index]
                                              .image
                                              .toString(),
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Assets.Dammyimages),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
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
                        }
                      ),
                    ),
              priflleImagesListData!.length == 0
                  ? Container(
                      height: MediaQuery.of(context).size.height + 100,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 50),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8.0,
                            crossAxisCount: 3,
                            crossAxisSpacing: 8),
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            width: 100,
                            child: Shimmer.fromColors(
                              baseColor: Colors.white10,
                              highlightColor: Colors.grey,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: AppColors.black, width: 1)),
                                child: Icon(
                                  Icons.image,
                                  size: 35,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height + 100,
                      width: MediaQuery.of(context).size.width,
                      //   padding: EdgeInsets.only(bottom: 45),
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 50),
                      child: GridView.builder(
                        controller: scrollControllerFavritePost,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 8.0,
                            crossAxisCount: 3,
                            crossAxisSpacing: 8),

                      //  itemCount: priflleImagesListData!.length,
                        itemCount: isFavriteLoginMore ? priflleImagesListData!.length + 3 : priflleImagesListData!.length,
                        itemBuilder: (context, index) {
                          validator = 1;
                          print(_tabController!.index);
                          if (index < priflleImagesListData!.length) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: priflleImagesListData![index].type ==
                                  "pdf"
                                  ? PdfView(
                                  imagePath:
                                  priflleImagesListData![index]
                                      .image
                                      .toString(),
                                  postTime: "",
                                  onTep: () {
                                    pdfview(
                                        priflleImagesListData![index].image
                                            .toString(),
                                        priflleImagesListData![index]
                                            .description.toString(),
                                        priflleImagesListData![index].id,
                                        index
                                    );
                                  }
                              )
                                  : InkWell(
                                onTap: () {
                                  favriteImagediallog(
                                      priflleImagesListData![index].image
                                          .toString(),
                                      priflleImagesListData![index].description
                                          .toString(),
                                      priflleImagesListData![index].id,
                                      index
                                  );
                                },
                                child: FadeInImage.assetNetwork(
                                  placeholder:
                                  "assets/images/dammyImages.png",
                                  image: priflleImagesListData![index]
                                      .image
                                      .toString(),
                                  imageErrorBuilder: (c, o, s) =>
                                      Image.asset(
                                          "assets/images/dammyImages.png"),
                                  fit: BoxFit.cover,
                                ),
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
                        }
                      ),
                    ),
            ],
          ),
        ),
      ),
      bottomSheet: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPostScreen(),
              ));
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              //  color: Colors.white,
              ),
          child: Container(
            child: Image.asset(
              Assets.HomepadeSpiker,
              height: 30,
              width: 30,
            ),
          ),
        ),
      ),
    );
  }

  /// --> Delete Images Dialog

  deleteImagesDialog(int? imagesId, int arrayIndex, String fildName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          //  insetPadding: EdgeInsets.only(left: 10, right: 10),
          //  contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              Textfile.DeleteImagesText,
            ),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomeButton(
                onTap: () {
                  Navigator.pop(context);
                },
                ButtonColor: AppColors.ButtoneColor,
                ButtonName: Textfile.NO,
                ButtonHeight: 35,
                BorderRadiuss: 30,
                ButtonWidth: MediaQuery.of(context).size.width / 4,
              ),
              CustomeButton(
                onTap: () {
                  Navigator.pop(context);
                  deletePost(imagesId, arrayIndex, fildName /*'userpost'*/);
                },
                ButtonColor: AppColors.ButtoneColor,
                ButtonName: Textfile.Yes,
                ButtonHeight: 35,
                BorderRadiuss: 30,
                ButtonWidth: MediaQuery.of(context).size.width / 4,
              ),
            ],
          ),
        );
      },
    );
  }

  /// ---->  images Dialog

  imagediallog(String imagesPath, String description, int? imagesId,
      int arrayIndex, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: AppColors.white),
              // color: AppColors.greyShade1),
              margin: EdgeInsets.only(left: 1, right: 1, top: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        //  child: Image.network(imagesPath),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.Dammyimages,
                          image: imagesPath,
                          imageErrorBuilder: (c, o, s) =>
                              Image.asset(Assets.Dammyimages),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: 35,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                deleteImagesDialog(imagesId, arrayIndex, "userpost");
                              },
                              child: Icon(
                                Icons.delete,
                                size: 25,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                print("fff");

                                Navigator.pop(context);
                                imageFileListMor = null;
                                EditImagediallog(
                                  imagesId.toString(),
                                  description,
                                  imagesPath,
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //   height: textMaxLine == 1 ? 35 :MediaQuery.of(context).size.height/2,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black), /*maxLines: textMaxLine== 1 ? 2 : 100 ,*/
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

  /// -----> my Pdf View Dialog

  myPdfdialog(String imagesPath, String description, int? imagesId,
      int arrayIndex, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: AppColors.white),
              // color: AppColors.greyShade1),
              margin: EdgeInsets.only(left: 1, right: 1, top: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        //  child: Image.network(imagesPath),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2,
                          width: MediaQuery.of(context).size.width,
                          child: SfPdfViewer.network(
                            //onTap: (details) => onTep!(),
                            enableDoubleTapZooming: false,
                            maxZoomLevel: 1,
                            initialZoomLevel: 1,
                            imagesPath,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5))),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                deleteImagesDialog(imagesId, arrayIndex, "userpost");
                              },
                              child: Icon(
                                Icons.delete,
                                size: 25,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                print("fff");

                                Navigator.pop(context);
                                imageFileListMor = null;
                                EditImagediallog(
                                  imagesId.toString(),
                                  description,
                                  imagesPath,
                                );
                              },
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //   height: textMaxLine == 1 ? 35 :MediaQuery.of(context).size.height/2,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black), /*maxLines: textMaxLine== 1 ? 2 : 100 ,*/
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

  /// ---> Edit Image Dialog

  EditImagediallog(
    String postId,
    String description,
    String imagePath,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white),
              margin: EdgeInsets.only(left: 3, right: 3, top: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      /*     Container(
                        padding: EdgeInsets.all(3),
                        //  child: Image.network(imagesPath),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.Dammyimages,
                          image: imagePath,
                          imageErrorBuilder: (c, o, s) =>
                              Image.asset(Assets.ImageNotFound),
                          fit: BoxFit.cover,
                        ),
                      ),*/
                      imageFileListMor == null
                          ? Container(
                              padding: EdgeInsets.all(3),
                              child: FadeInImage.assetNetwork(
                                placeholder: Assets.Dammyimages,
                                image: imagePath!,
                                imageErrorBuilder: (c, o, s) =>
                                    Image.asset(Assets.ImageNotFound),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              /*    height: 100,
                        width: 100,*/
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1)),
                              child: imageFileListMor!.path.substring(
                                          (imageFileListMor!.path.length - 4)
                                              .clamp(
                                                  0,
                                                  imageFileListMor!
                                                      .path.length)) ==
                                      ".pdf"
                                  ? PdfViewFile(
                                      pdfHeight:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      imagePath: imageFileListMor!,
                                      postTime: '',
                                      onTep: () {},
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        File(imageFileListMor!.path),
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.height,
                                      ),
                                    ),
                            ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _showPickerMor(
                            context,
                            postId.toString(),
                            description,
                            imagePath,
                          );
                        },
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.edit,
                            size: 25,
                            color: AppColors.black,
                          ),
                          //  child: IconButton(icon: Icon(Icons.delete,size: 25,color: AppColors.black,),onPressed: () {    deletePost(postId); },),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      Textfile.imageEditTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: AppColors.black),
                    ),
                  ),
                  Container(
                    height: 35,
                    alignment: Alignment.bottomLeft,
                    margin:
                        const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: TextField(
                      controller: title,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: const UnderlineInputBorder(),
                        hintText: Textfile.ImagesTitle,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      Textfile.imageEditDescription,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, color: AppColors.black),
                    ),
                  ),
                  Container(
                    height: 35,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: TextField(
                      controller: decripaction,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: Textfile.ImagesDescripation,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomeButton(
                      ButtonColor: AppColors.NewPostPostBtn,
                      TextColor: AppColors.white,
                      BorderRadiuss: 30,
                      ButtonHeight: 40,
                      ButtonName: "Submit",
                      LeftMargin: MediaQuery.of(context).size.width / 4,
                      RightMargin: MediaQuery.of(context).size.width / 4,
                      onTap: () {
                        /* documentType ==  "" ?editPost(
                            postId,
                            title.text,
                            decripaction.text,
                            imagePath,
                            "",
                          )  :*/
                        if (imageFileListMor != null) {
                          documentType == ".pdf"
                              ? editPost(
                                  postId,
                                  title.text,
                                  decripaction.text,
                                  imagePath,
                                  "pdf",
                                )
                              : editPost(
                                  postId,
                                  title.text,
                                  decripaction.text,
                                  imagePath,
                                  "image",
                                );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Plase Select Image",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ----> Favorite images Dialog

  favriteImagediallog(
      String imagesPath, String description, int? imagesId, int arrayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.white),
              // color: AppColors.greyShade1),
              margin: EdgeInsets.only(left: 3, right: 3, top: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(

                        padding: EdgeInsets.all(3),
                        //  child: Image.network(imagesPath),
                        child: FadeInImage.assetNetwork(
                          placeholder: Assets.Dammyimages,
                          image: imagesPath,
                          imageErrorBuilder: (c, o, s) =>
                              Image.asset(Assets.ImageNotFound),
                          fit: BoxFit.cover,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);

                          deleteImagesDialog(imagesId, arrayIndex, "favpost");
                        },
                        child: Container(
                          width: 35,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5))),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.delete,
                            size: 25,
                            color: AppColors.black,
                          ),
                          //  child: IconButton(icon: Icon(Icons.delete,size: 25,color: AppColors.black,),onPressed: () {    deletePost(postId); },),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    //   height: textMaxLine == 1 ? 35 :MediaQuery.of(context).size.height/2,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black), /*maxLines: textMaxLine== 1 ? 2 : 100 ,*/
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

  /// -----> Show Pdf

  pdfview(String imagesPath, String description, int? imagesId, int arrayIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          insetPadding: EdgeInsets.only(left: 10, right: 10),
          contentPadding: EdgeInsets.all(2),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.white),
                 // margin: EdgeInsets.only(left: 2, right: 2),
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width,
                              child: SfPdfViewer.network(imagesPath)),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              deleteImagesDialog(imagesId, arrayIndex, "favpost");
                            },
                            child: Container(
                              width: 35,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5))),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.delete,
                                size: 25,
                                color: AppColors.black,
                              ),
                              //  child: IconButton(icon: Icon(Icons.delete,size: 25,color: AppColors.black,),onPressed: () {    deletePost(postId); },),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Text(
                          description,
                          style: TextStyle(
                              fontSize: 15,
                              color: AppColors
                                  .black), /*maxLines: textMaxLine== 1 ? 2 : 100 ,*/
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// ----> Get Favorite Post Api

  getFavoritePostApi() async {
    String tokenShard;

    tokenShard = await sharedPreference.istoken();
    print("Token ---> $tokenShard");

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.GetFavoritePost + favroteApiPageNumber.toString()),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $tokenShard',
        },
      );

      GetFavoritePostModel getFavoritePostModel =
          GetFavoritePostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> get Favorite Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusgetFavoritePost = getFavoritePostModel.status;
        messagegetFavoritePost = getFavoritePostModel.message;
        priflleImagesListData1 = getFavoritePostModel.data;

        priflleImagesListData!.addAll(priflleImagesListData1!);

        print("statusgetFavoritePost --------------> $statusgetFavoritePost");
        print("messagegetFavoritePost --------------> $messagegetFavoritePost");
        print("priflleImagesListData --------------> $priflleImagesListData");
        print(
            "priflleImagesListData length --------------> ${priflleImagesListData!.length}");

        setState(() {});

        if (statusgetFavoritePost == true) {

        } else {
          print("get Favorite Post Status is $statusgetFavoritePost");
        }
      } else {
        print(
            "get Favorite Post Api Responce is =====>>>> ${response.statusCode}");
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
    }
  }

  /// ----> Get User Upload Images

  getUSerUploadPostApi() async {
    String tokenShard;

    tokenShard = await sharedPreference.istoken();
    print("Token ---> $tokenShard");

    print("Url >>>> ${ApiUrl.GetUserUploadPost}");
    try {
      final response = await http.get(
        Uri.parse(ApiUrl.GetUserUploadPost + userPostApiPageNumber.toString()),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $tokenShard',
        },
      );
      GetUserUploadPostModel getUserUploadPostModel =
          GetUserUploadPostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> get Favorite Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusUserUpaloadPost = getUserUploadPostModel.status;
        messageUserUpaloadPost = getUserUploadPostModel.message;
        currentPageUserUpaloadPost = getUserUploadPostModel.currentPage;
        countUserUpaloadPost = getUserUploadPostModel.count;
        perPageUserUpaloadPost = getUserUploadPostModel.perPage;
        UserUploadDataList1 = getUserUploadPostModel.data;

        UserUploadDataList!.addAll(UserUploadDataList1!);

        print("status User UpaloadPost --------------> $statusUserUpaloadPost");
        print(
            "message User UpaloadPost --------------> $messageUserUpaloadPost");
        print(
            "currentPage User UpaloadPost --------------> $currentPageUserUpaloadPost");
        print(
            "count User UpaloadPost length --------------> ${countUserUpaloadPost}");
        print(
            "perPage User UpaloadPost length --------------> ${perPageUserUpaloadPost}");
        print(
            "User UploadDataList length --------------> ${UserUploadDataList!.length}");

        setState(() {});

        if (statusgetFavoritePost == true) {
        } else {
          print("get Favorite Post Status is $statusgetFavoritePost");
        }
      } else {
        print(
            "get Favorite Post Api Responce is =====>>>> ${response.statusCode}");
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
    }
  }

  /// ----> Delete Post Api

  deletePost(int? postId, int arrayIndex, String fildName) async {
    String UserLoginToken;
    UserLoginToken = await sharedPreference.istoken();
    print("User Login Token ====> $UserLoginToken");
    try {
      final response = await http.post(
        Uri.parse(ApiUrl.DeletePost),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $UserLoginToken",
        },
        body: {
          "id": "$postId",
        },
      );

      DeletePostModel otpModel =
          DeletePostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> delete post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusDeletePost = otpModel.status;
        messageDeletePost = otpModel.message;

        print("statusDeletePost --------------> $statusDeletePost");
        print("messageDeletePost --------------> $messageDeletePost");

        if (statusDeletePost == true) {
          setState(() {
            fildName == "userpost"
                ? UserUploadDataList!.removeAt(arrayIndex)
                : priflleImagesListData!.removeAt(arrayIndex);
          });

          Fluttertoast.showToast(
              msg: messageDeletePost.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          print("delete post Status is $statusDeletePost");
        }
      } else {
        print("delete post Api Responce is =====>>>> ${response.statusCode}");
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
    }
  }

  /// ---> Edite Api

  Future<d.Response> editPost(String postId, String title, String description,
      String imagePath, String type) async {
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
    String tokenShard;

    tokenShard = await sharedPreference.istoken();
    print("Token ---> $tokenShard");
    String url = ApiUrl.EditPodt;
    print("url ---> $url");

    try {
      d.FormData formData = d.FormData();

      if (imageFileListMor != null) {
        //  File file = new File.fromUri(Uri.parse(imageFileListMor!.path));
        File file = File.fromUri(Uri.parse(imageFileListMor!.path));
        formData.files.add(
          MapEntry(
            "image",
            d.MultipartFile.fromFileSync(file!.path, filename: file.path),
          ),
        );
        print("-------------------");
      } else {
        print("======>> Images is Ematy <<======");
      }

      print("===>==>==>  id => ${postId}");
      print("===>==>==>  title => ${title}");
      print("==>==>==> description ==> ${description}");
      // print("==>==>==> image ==> ${imagePath}");
      print("==>==>==> type ==> ${type}");

      formData.fields.add(MapEntry('id', postId));
      formData.fields.add(MapEntry('title', title));
      formData.fields.add(MapEntry('description', description));
      //   formData.fields.add(MapEntry('image', imagePath));
      formData.fields.add(MapEntry('type', type));

      d.Response response;
      print(url);

      d.Dio dio = d.Dio();

      response = await dio.post(url,
          data: formData,
          options: Options(
            followRedirects: false,
            headers: {
              "Accept": "application/json",
              'Authorization': 'Bearer $tokenShard',
            },
            validateStatus: (status) => true,
          ));
      //pd.close();
      print('Response request: ${response.requestOptions}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      print("-------------->>>>>>> Login Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.data}");

      EditPostModel editPostModel = EditPostModel.fromJson(response.data);

      if (response.statusCode == 200) {
        statusEditPost = editPostModel.status;
        messageEditPost = editPostModel.message;

        print("statusEditPost --------------> $statusEditPost");
        print("messageEditPost --------------> $messageEditPost");

        if (statusEditPost == true) {
          Navigator.pop(context);
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: messageEditPost.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
          print(" Edit post Status is $messageEditPost");
        }
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        print("Edit post Api Responce is =====>>>> ${response.statusCode}");
      }
      return response;
    } catch (e) {
      Navigator.pop(context);
      Navigator.pop(context);
      print("exception" + e.toString());
      // hideLoader();
      //pd.close();
      return d.Response(requestOptions: RequestOptions(path: url));
    }
  }

  /// ---> User Profile

  userProfileLogo(String tokan) async {
    String UserLoginToken;

    UserLoginToken = await sharedPreference.istoken();
    print("User Login Token ====> $UserLoginToken");

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.UserProfileLogo),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $tokan",
        },
      );

      UserProfilePhotoModel userProfilePhotoModel =
          UserProfilePhotoModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Get Post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        print(
            "getPostModel status --------------> ${userProfilePhotoModel.status}");
        print("statusGetPost --------------> $userProfilePhotoModel");

        statusUserProfileLogo = userProfilePhotoModel.status;

        if (statusUserProfileLogo == true) {
          setState(() {
            messageUserProfileLogo = userProfilePhotoModel.message;
            nameUserProfileLogo = userProfilePhotoModel.data!.name;
            imageUserProfileLogo = userProfilePhotoModel.data!.image;
            //setState(() {});
            mobileUserProfileLogo = userProfilePhotoModel.data!.mobile;
            createdAtUserProfileLogo = userProfilePhotoModel.data!.createdAt;
            updatedAtUserProfileLogo = userProfilePhotoModel.data!.updatedAt;
          });
          print(
              "message User Profile Logo  --------------> $messageUserProfileLogo");
          print(
              "name User Profile Logo t --------------> $nameUserProfileLogo");
          print(
              "image User Profile Logo  --------------> $imageUserProfileLogo");
          print(
              "mobile User Profile Logoo  --------------> $mobileUserProfileLogo");
        } else {
          print("Get Post Status is $statusUserProfileLogo");
          setState(() {});
        }
      } else {
        print("Get Post Api Responce is =====>>>> ${response.statusCode}");
        setState(() {});
      }
    } catch (e) {
      print("Catch is User Profile --------->>>>>>>>>>>>>>>>>>>$e");
      setState(() {});
    }
  }

  /// ----> Upload Profile Logo

  /*uploadProfileLogo(String imagesLink) async {
    String UserLoginToken;
    String? mobileNumber;
    String? name;

    UserLoginToken = await sharedPreference.istoken();
    mobileNumber = await sharedPreference.ismobileNumber();
    name = await sharedPreference.isuserName();

    print("User Login Token ====> $UserLoginToken");
    print("User number ---->> $name");
    print("User mobile number ---->> $mobileNumber");

    try {
      final response = await http.post(
        Uri.parse(ApiUrl.UpdateProfile),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $UserLoginToken",
        },
        body: {
          "name": "$name",
          "mobile": "$mobileNumber",
          "image": "$imagesLink",
        },
      );

      DeletePostModel otpModel =
      DeletePostModel.fromJson(jsonDecode(response.body));

      print("-------------->>>>>>> Edit post Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.body}");

      if (response.statusCode == 200) {
        statusEditPost = otpModel.status;
        messageEditPost = otpModel.message;

        print("statusEditPost --------------> $statusEditPost");
        print("messageEditPost --------------> $messageEditPost");

        if (messageEditPost == true) {
          Fluttertoast.showToast(
              msg: messageEditPost.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          print(" Edit post Status is $messageEditPost");
        }
      } else {
        print("Edit post Api Responce is =====>>>> ${response.statusCode}");
      }
    } catch (e) {
      print("Catch is --------->>>>>>>>>>>>>>>>>>>$e");
    }
  }*/

  Future<d.Response> uploadProfileLogo(String imagesLink) async {
    String UserLoginToken;
    String? mobileNumber;
    String? name;

    UserLoginToken = await sharedPreference.istoken();
    mobileNumber = await sharedPreference.ismobileNumber();
    name = await sharedPreference.isuserName();

    print("User Login Token ====> $UserLoginToken");
    print("User number ---->> $name");
    print("User mobile number ---->> $mobileNumber");

    String url = ApiUrl.UpdateProfile;
    try {
      d.FormData formData = d.FormData();

      if (imageFileListMor != null) {
        File file = new File.fromUri(Uri.parse(imageFileListMor!.path));
        formData.files.add(
          MapEntry(
            "image",
            d.MultipartFile.fromFileSync(file!.path, filename: file.path),
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
            headers: {
              "Accept": "application/json",
              "Authorization": "Bearer $UserLoginToken",
            },
            validateStatus: (status) => true,
          ));
      //pd.close();
      print('Response request: ${response.requestOptions}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.data}');

      print("-------------->>>>>>> Login Api Responce --->> " +
          response.statusCode.toString());
      print("response body ------------>> ${response.data}");

      UpdateProfileLogoModel updateProfileLogoModel =
          UpdateProfileLogoModel.fromJson(response.data);

      if (response.statusCode == 200) {
        statusUploadProfilePhoto = updateProfileLogoModel.status;
        messageUploadProfilePhoto = updateProfileLogoModel.message.toString();

        print("StatusLogin --------------> $statusUploadProfilePhoto");
        print("MessageLogin --------------> $messageUploadProfilePhoto");

        if (statusUploadProfilePhoto!) {
          Fluttertoast.showToast(
              msg: messageUploadProfilePhoto.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          print("Login Status Is ----->> $statusUploadProfilePhoto");
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

  Future<void> getTokans() async {
    String UserLoginToken;

    UserLoginToken = await sharedPreference.istoken();
    userProfileLogo(UserLoginToken);
  }
}

class _SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  _SliverAppBarTabDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
