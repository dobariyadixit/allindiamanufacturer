import 'dart:convert';
import 'dart:io';

import 'package:allindiamanufacturer/ApiServices/ApiModelClass/UpdateProfileLogoModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/UserProfilePhotoModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/AppBar/ProfileView.dart';
import 'package:allindiamanufacturer/CustomeUi/Widget/CustomeButton/CustomeButton.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as d;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpadetProfileDetailsScreen extends StatefulWidget {

  String userProfileLogo;
  String businessName;
  String firstName;
  String lastName;
  String gender;
  String birthDate;

  UpadetProfileDetailsScreen({
    required this.userProfileLogo,
    required this.businessName,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,

   super.key
  });
  @override
  State<UpadetProfileDetailsScreen> createState() => _UpadetProfileDetailsScreenState();
}

class _UpadetProfileDetailsScreenState extends State<UpadetProfileDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("user Profile Logo ---> ${widget.userProfileLogo}");
    print("user business Name ---> ${widget.businessName}");
    print("user first Name ---> ${widget.firstName}");
    print("user last Name ---> ${widget.lastName}");
    print("user gender ---> ${widget.gender}");
    print("user birth Date ---> ${widget.birthDate}");

    userNameController.text = widget.businessName.toString();
    firstNameController.text = widget.firstName.toString();
    lastNameController.text = widget.lastName.toString();
    dateInput.text = widget.birthDate.toString();
    _radioVal = widget.gender.toString();


    userProfileLogo();
  }

  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dateInput = TextEditingController();

  SharedPreference sharedPreference = SharedPreference();

  //int _radioSelected = 1;
  String? _radioVal;

  bool? statusUserProfileLogo;
  String? messageUserProfileLogo;
  int? idUserProfileLogo;
  String? nameUserProfileLogo;
  String? firstNameUserProfileLogo;
  String? lastNameUserProfileLogo;
  String? dateOfBirthUserProfileLogo;
  String? genderUserProfileLogo;
  String? imageUserProfileLogo;
  String? mobileUserProfileLogo;


  bool? statusUploadProfilePhoto=false;
  String? messageUploadProfilePhoto = "";


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
  XFile? imageFileListMor;
  PickedFile? pickedImageMor;
  final ImagePicker pickerMor = ImagePicker();

  void selectGalleryMor() async {
    final XFile? selectImages = await imagePickerMor.pickMedia();
    if (selectImages!.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = selectImages;
      upadetProfilePhoto(imageFileListMor!.path);
      setState(() {});
    }
  }

  imgFromCameraMor() async {
    pickedImageMor = await pickerMor.getImage(source: ImageSource.camera);
    XFile imageMor = XFile(pickedImageMor!.path);
    if (imageMor!.path.isNotEmpty) {
      imageFileListMor = null;
      imageFileListMor = imageMor;
      upadetProfilePhoto(imageFileListMor!.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
                onTap: (){
                  _showPickerMor(context);
                },
                child:
                Center(
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
                               /*
                               FadeInImage.assetNetwork(
                                  placeholder: Assets.Dammyimages,
                                  image: *//*widget.userProfileLogo*//*imageUserProfileLogo.toString(),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                                  fit: BoxFit.cover,
                                ),
                                */
                              //  Image.network(imageUserProfileLogo.toString(),
                                Image.network(widget.userProfileLogo.toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                                ),

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
                    ))
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Icon(Icons.person,size: 25,color: AppColors.greyShade8,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.businessName,style: TextStyle(color: AppColors.greyShade8,),),
                      Container(
                       // color: Colors.deepOrange,
                        width: MediaQuery.of(context).size.width - 60,
                        child: TextField(
                          controller: userNameController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.edit,size: 20,),
                            border: InputBorder.none,
                            hintText: nameUserProfileLogo,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Icon(Icons.person,size: 25,color: Colors.transparent,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.firstName,style: TextStyle(color: AppColors.greyShade8,),),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        child: TextField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.edit,size: 20,),
                            border: InputBorder.none,
                            hintText:  lastNameUserProfileLogo ?? "Enter Your First Name"
                            ,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Icon(Icons.person,size: 25,color: Colors.transparent,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.lastName,style: TextStyle(color: AppColors.greyShade8,),),
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        child: TextField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.edit,size: 20,),
                            border: InputBorder.none,
                            hintText:  lastNameUserProfileLogo ?? "Enter Your Last Name",
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 5),
              child: Row(
                children: [
                   Container(
                      height: 70,
                      child: Icon(Icons.female,size: 25,color: AppColors.greyShade8,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.SelectYourGender,style: TextStyle(color: AppColors.greyShade8,),),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(Textfile.Male),
                            Radio(
                              value: Textfile.Male,
                              groupValue: _radioVal,
                              activeColor: AppColors.deepOrange,
                              onChanged: (value) {
                                setState(() {
                                  // _radioSelected = value!;
                                  _radioVal = value.toString();
                                  print("_radioVal ---> $_radioVal");
                                });
                              },
                            ),
                            Text(Textfile.Female),
                            Radio(
                              value: Textfile.Female,
                              groupValue: _radioVal,
                              activeColor: AppColors.deepOrange,
                              onChanged: (value) {
                                setState(() {
                                  //_radioVal = value!;
                                  _radioVal = value.toString();
                                  print("_radioSelected ---> $_radioVal");
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
              child: Row(
                children: [
                  Container(
                      height: 70,
                      child: Icon(Icons.calendar_month,size: 25,color: AppColors.greyShade8,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.SelectYourBirthdayDate,style: TextStyle(color: AppColors.greyShade8,),),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 25,
                        width: MediaQuery.of(context).size.width - 60,
                        child: TextField(
                          controller: dateInput,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit,size: 20,),
                              border: InputBorder.none,
                              hintText: dateOfBirthUserProfileLogo?? "Enter Date"
                          ),
                          readOnly: true,
                          //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime.now());

                            if (pickedDate != null) {
                              print(pickedDate);
                              String formattedDate =
                              DateFormat('dd-MM-yyyy').format(pickedDate);
                              //    DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package => 16-03-2023
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("pickedDate is null ");
                              print("pickedDate ------> $pickedDate");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          /*  Container(
              margin: EdgeInsets.only(left: 10,right: 10),
              child: Row(
                children: [
                  Container(
                      height: 70,
                      child: Icon(Icons.call,size: 25,color: AppColors.greyShade8,)),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Textfile.Phone,style: TextStyle(color: AppColors.greyShade8,),),
                      SizedBox(height: 10,),
                      Text(mobileUserProfileLogo ?? "xxxxxxxxxx"),
                    ],
                  )
                ],
              ),
            ),*/
          ],
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: CustomeButton(
          onTap: () {

            uploadProfileLogo(
                userNameController.text,
                firstNameController.text,
                lastNameController.text,
                _radioVal.toString(),
                dateInput.text,
            );

          },
          alignment: Alignment.center,
          ButtonName: Textfile.SubmitUpdeatProfile,
          ButtonWidth: MediaQuery.of(context).size.width / 1.3,
          ButtonHeight: 50,
          TextSize: 19,
          TextColor: AppColors.white,
          BorderRadiuss: 30,
        ),
      ),
    );
  }

  /// ---> User Profile

  userProfileLogo() async {
    String UserLoginToken;

    UserLoginToken = await sharedPreference.istoken();
    print("User Login Token ====> $UserLoginToken");

    try {
      final response = await http.get(
        Uri.parse(ApiUrl.UserProfileLogo),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $UserLoginToken",
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
          messageUserProfileLogo = userProfilePhotoModel.message;
          nameUserProfileLogo = userProfilePhotoModel.data!.name;
          imageUserProfileLogo = userProfilePhotoModel.data!.image;
          mobileUserProfileLogo = userProfilePhotoModel.data!.mobile;
          firstNameUserProfileLogo = userProfilePhotoModel.data!.firstName;
          lastNameUserProfileLogo = userProfilePhotoModel.data!.lastName;
          dateOfBirthUserProfileLogo = userProfilePhotoModel.data!.dateOfBirth;
          genderUserProfileLogo = userProfilePhotoModel.data!.gender;


          _radioVal = genderUserProfileLogo;

          print(
              "message User Profile Logo  --------------> $messageUserProfileLogo");
          print(
              "name User Profile Logo t --------------> $nameUserProfileLogo");
          print(
              "image User Profile Logo  --------------> $imageUserProfileLogo");
          print("mobile User Profile Logoo  --------------> $mobileUserProfileLogo");
          print("firstName User Profile Logo  --------------> $firstNameUserProfileLogo");
          print("lastName User Profile Logo  --------------> $lastNameUserProfileLogo");
          print("dateOfBirth User Profile Logo  --------------> $dateOfBirthUserProfileLogo");
          print("gender User Profile Logo  --------------> $genderUserProfileLogo");

          setState(() {});
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

  /// ----> Upadet Profile Api
  Future<d.Response> uploadProfileLogo( String bussnesName , String firstName , String lastName ,
      String gender , String birthdayDate ) async {

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
    String? mobileNumber;
    String? name;

    UserLoginToken = await sharedPreference.istoken();
    mobileNumber = await sharedPreference.ismobileNumber();
    name = await sharedPreference.isuserName();

    print("User Login Token ====> $UserLoginToken");
    print("User number ---->> $name");
    print("User mobile number ---->> 1 $mobileNumber");

    String url = ApiUrl.UpdateProfile;
      print("User mobile number ---->> 2 $mobileNumber");
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
        print("User mobile number ---->> 3 $mobileNumber");
      }
      else {
        print("======>> Images is Ematy <<======");
      }
      print("User mobile number ---->> 4 $mobileNumber");
      formData.fields.add(MapEntry('name', bussnesName.isEmpty ? nameUserProfileLogo.toString() : bussnesName));
      print("User mobile number ---->> 5 $mobileNumber");
      formData.fields.add(MapEntry('first_name', firstName.isEmpty ? firstNameUserProfileLogo.toString() : firstName));
      print("User mobile number ---->> 6 $mobileNumber");
      formData.fields.add(MapEntry('last_name', lastName.isEmpty ? lastNameUserProfileLogo.toString() : lastName));
      print("User mobile number ---->> 7 $mobileNumber");
      formData.fields.add(MapEntry('gender', gender.isEmpty ? dateOfBirthUserProfileLogo.toString() : gender));
      print("User mobile number ---->> 8 $mobileNumber");
      formData.fields.add(MapEntry('date_of_birth', birthdayDate.isEmpty ? genderUserProfileLogo.toString() : birthdayDate ));


      print("===>==>==>  name => ${name}");
      print("===>==>==>  userName => ${bussnesName}");
      print("==>==>==> mobile ==> ${mobileNumber}");



      formData.fields.add(MapEntry('mobile', mobileNumber));


      d.Response response;
      print(url);

      d.Dio dio = d.Dio();

      response = await dio.post(url,
          data: formData,
          options: Options(
            followRedirects: false,
            headers: {"Accept": "application/json",
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

      UpdateProfileLogoModel updateProfileLogoModel = UpdateProfileLogoModel.fromJson(response.data);

      if (response.statusCode == 200) {

        statusUploadProfilePhoto = updateProfileLogoModel.status;
        messageUploadProfilePhoto = updateProfileLogoModel.message.toString();

        print("StatusLogin --------------> $statusUploadProfilePhoto");
        print("MessageLogin --------------> $messageUploadProfilePhoto");

        if (statusUploadProfilePhoto!) {

          Navigator.pop(context);
          Fluttertoast.showToast(
              msg: messageUploadProfilePhoto.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        else {
          Navigator.pop(context);
          print("Login Status Is ----->> $statusUploadProfilePhoto");
        }
      } else {
        Navigator.pop(context);
        print("Login Api Reponce is -------------->> ${response.statusCode}");
      }
      return response;
    } catch (e) {
      Navigator.pop(context);
      print("exception  -->> " + e.toString());
      // hideLoader();
      //pd.close();
      return d.Response(requestOptions: RequestOptions(path: url));
    }
  }

  /// ----> Profile picture Dialoag box
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
                    SizedBox(height: 10,),
                    ClipRRect(
                      borderRadius:
                      BorderRadius.circular(10),
                      child: Container(
                        child: Image.file(
                          File(imageFileListMor!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15,left: 15,right: 15),
                      child: Text(Textfile.UpdateThisProfilePicture,style: TextStyle(fontSize: 15,color: AppColors.black,fontWeight: FontWeight.bold),),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomeButton(
                          onTap: () { Navigator.pop(context); },
                          ButtonName: "No",
                          ButtonColor: AppColors.ButtoneColor,
                          ButtonHeight: 35,
                          ButtonWidth: 100,
                          BorderRadiuss: 50,
                          TextFontWeight: FontWeight.w600,
                        ),
                        CustomeButton(
                          onTap: () {
                           // uploadProfileLogo(imageFileListMor!.path,userNameController.text);
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
}
