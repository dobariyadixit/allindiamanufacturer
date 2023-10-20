import 'dart:convert';
import 'dart:io';

import 'package:allindiamanufacturer/ApiServices/ApiModelClass/AddPostModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/CustomeButton/CustomeButton.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/PdfView/PdfViewFile.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:allindiamanufacturer/TextProperty/Textsize.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../CustomeUi/Widget/PdfView/PdfView.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  SharedPreference sharedPreference = SharedPreference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserDetais();
  }

  getUserDetais() async {
    tokenUser = await sharedPreference.istoken();
    nameUser = await sharedPreference.isuserName();
    mobileUser = await sharedPreference.ismobileNumber();
    userIdUser = await sharedPreference.isuserId();

    print("tokenUser -----> $tokenUser");
    print("nameUser -----> $nameUser");
    print("mobileOtpUser -----> $mobileUser");
    print("userIdOtpUser -----> $userIdUser");
  }

  String? tokenUser;
  String? nameUser;
  String? mobileUser;
  String? userIdUser;

  bool? statusAddPost;
  String? messageAddPost;

  final decripaction = TextEditingController();

  void _showPickerMor(context) {
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
                        selectGalleryMor();
                        Navigator.pop(context);
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(Textfile.Camera),
                    onTap: () {
                      imgFromCameraMor();
                      Navigator.pop(context);
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

  void selectGalleryMor() async {
    final XFile? selectImages = await imagePickerMor.pickMedia();
    if (selectImages!.path.isNotEmpty) {
      imageFileListMor = null;
      File file = File(selectImages.path);
      imageFileListMor = file;
      setState(() {});
    }
  }

  imgFromCameraMor() async {
    pickedImageMor = await pickerMor.getImage(source: ImageSource.camera);
    File imageMor = File(pickedImageMor!.path);
    if (imageMor!.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = imageMor;
      setState(() {});
    }
  }

  String fileurl =
      "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";

  getNewDownloads() {
    File file = File(fileurl);
    String fileName =
        file.path.split(Platform.pathSeparator).last; // my_image.jpg
    //You can download a single file
    FileDownloader.downloadFile(
        url: fileurl,
        name: fileName,
        //THE FILE NAME AFTER DOWNLOADING,
        onProgress: (String? fileName, double progress) {
          print('FILE fileName HAS PROGRESS $progress');
        },
        onDownloadCompleted: (String path) {
          print('FILE DOWNLOADED TO PATH: $path');
        },
        onDownloadError: (String error) {
          print('DOWNLOAD ERROR: $error');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Textfile.NewPost,
              style: TextStyle(
                  fontSize: TextSize.NewPostTitle,
                  color: AppColors.black,
                  fontWeight: FontWeight.w800),
            ),

            /* Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              height: 0.7,
              color: AppColors.black,
            ),*/
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 0.9,
              color: AppColors.black,
            ),

            //
            Center(
              child: Text(
                Textfile.NewPostIntructions,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: TextSize.NewPostIntructions,
                ),
              ),
            ),

            //
            Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Text(
                  Textfile.NewPostIntructionsBody,
                  style: TextStyle(fontSize: TextSize.NewPostIntructionsBody),
                )),
          ],
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          // color: Colors.grey,
          // height: MediaQuery.of(context).size.height / 4,
          margin: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 7,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 15, bottom: 5, left: 15, right: 15),
                      child: InkWell(
                        onTap: () {
                          //  getNewDownloads();

                          _showPickerMor(context);
                        },
                        child: imageFileListMor == null
                            ? Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.image,
                                      color: AppColors.blackShade3,
                                    ),
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.only(top: 5, right: 5),
                                      alignment: Alignment.topRight,
                                      height: 100,
                                      width: 100,
                                      child: InkWell(
                                          onTap: () {
                                            deleteImagesDialog();
                                          },
                                          child: Icon(Icons.cancel))),
                                ],
                              )
                            : ClipRRect(
                            //    borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1)),
                                      child: imageFileListMor!.path.substring(
                                                  (imageFileListMor!.path.length - 4).clamp
                                                    (0, imageFileListMor!.path.length)) == ".pdf"
                                          ? PdfViewFile(
                                              imagePath: imageFileListMor!,
                                              postTime: '',
                                              onTep: () {},
                                            )
                                          : ClipRRect(
                                        //     borderRadius: BorderRadius.circular(8),
                                            child: Image.file(
                                              //  errorBuilder: Image.asset(Assets.Dammyimages),
                                             errorBuilder: (c,o,s) => Image.asset(Assets.ImageNotFound),
                                                File(imageFileListMor!.path),
                                                fit: BoxFit.cover,
                                              ),
                                          ),
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.only(top: 5, right: 5),
                                        alignment: Alignment.topRight,
                                        height: 100,
                                        width: 100,
                                        child: InkWell(
                                            onTap: () {
                                              deleteImagesDialog();
                                            },
                                            child: Icon(Icons.cancel))),
                                  ],
                                ),
                              ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width- 150,
                      child: TextField(
                        controller: decripaction,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: Textfile.ImagesDescripation,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.NewPostPostBtn,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: InkWell(
                    onTap: () {
                      addPostApi("demo", "image", decripaction.text
                          /*  nameUser!,
                        "image",
                        decripaction.text,*/
                          );
                    },
                    child: Center(
                        child: Text(
                      Textfile.post,
                      style: TextStyle(
                          fontSize: TextSize.postBtn,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<d.Response> addPostApi(
      String name, String type, String description) async {
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
    String url = ApiUrl.AddPost;
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
        print("-------------------");
      } else {
        print("======>> Images is Ematy <<======");
      }

      print("===>==>==>  title => ${name}");
      print("==>==>==> type ==> ${type}");
      print("==>==>==> description ==> ${description}");

      formData.fields.add(MapEntry('title', name));
      formData.fields.add(MapEntry('type', type));
      formData.fields.add(MapEntry('description', description));

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

      if (response.statusCode == 200) {
        AddPostModel addPostModel = AddPostModel.fromJson(response.data);

        statusAddPost = addPostModel.status;
        messageAddPost = addPostModel.message;

        print("StatusAddpost --------------> $statusAddPost");
        print("MessageAddpost --------------> $messageAddPost");

        if (statusAddPost == true) {
          imageFileListMor = null;
          decripaction.clear();
          setState(() {});
          Navigator.pop(context);

          Fluttertoast.showToast(
              msg: messageAddPost.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Navigator.pop(context);
          print("Login Status Is ----->> $statusAddPost");
        }
      } else {
        Navigator.pop(context);
        print("Login Api Reponce is -------------->> ${response.statusCode}");
      }
      return response;
    } catch (e) {
      Navigator.pop(context);
      print("exception" + e.toString());
      // hideLoader();
      //pd.close();
      return d.Response(requestOptions: RequestOptions(path: url));
    }
  }

  deleteImagesDialog() {
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
                  print("imageFileListMor ---> $imageFileListMor");
                  imageFileListMor = null;
                  setState(() {});
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
// Future<void> getDownload(String fileurl1) async {
//
//   Map<Permission, PermissionStatus> statuses = await [
//   Permission.storage,
//   //add more permission to request here.
//   ].request();
//
//   if(statuses[Permission.storage]!.isGranted){
//     var dir = await DownloadsPathProvider.downloadsDirectory;
//   if(dir != null){
//   String savename = "file.pdf";
//   String savePath = dir.path + "/$savename";
//   print(savePath);
//   //output:  /storage/emulated/0/Download/banner.png
//
//   try {
//
//          print("File is saved to download folder.");
//   } on DioError catch (e) {
//        print(e.message);
//     }
//   }
//   }else{
//   print("No permission to read and write.");
//   }
//
// }
}
