import 'dart:convert';
import 'package:allindiamanufacturer/Assets/AssetsScreen.dart';
import 'package:allindiamanufacturer/Screen/UpadetProfileDetailsScreen/UpadetProfileDetailsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as d;
import 'package:allindiamanufacturer/ApiServices/ApiModelClass/UserProfilePhotoModel.dart';
import 'package:allindiamanufacturer/ApiServices/ApiUrl/ApiUrl.dart';
import 'package:allindiamanufacturer/ColorScreen/Colors.dart';
import 'package:allindiamanufacturer/SharedPreferences/SharedPreferences.dart';
import 'package:allindiamanufacturer/TextProperty/TextFile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userProfileLogo();
  }

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  var dateInput = TextEditingController();

  SharedPreference sharedPreference = SharedPreference();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, // <-- SEE HERE
        ),
        elevation: 0,
        backgroundColor: AppColors.white,
        title:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Profile Details",style: TextStyle(color: AppColors.black),),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder:(context) => UpadetProfileDetailsScreen(
                  userProfileLogo: imageUserProfileLogo.toString(),
                  businessName: nameUserProfileLogo.toString(),
                  firstName: firstNameUserProfileLogo.toString(),
                  lastName: lastNameUserProfileLogo.toString(),
                  gender: genderUserProfileLogo.toString(),
                  birthDate: dateOfBirthUserProfileLogo.toString(),
                ),));
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  //  color: AppColors.grey,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Icon(Icons.edit,size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width,
              child: Image.network(imageUserProfileLogo.toString(),
                fit: BoxFit.cover,
                errorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
              ),
            ),*/
            InkWell(
              onTap: (){
                imagediallog(imageUserProfileLogo!,"");
              },
              child: Center(
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
                                    image: */
                              /*widget.userProfileLogo*/
                              /*imageUserProfileLogo.toString(),
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    imageErrorBuilder: (c,o,s) => Image.asset(Assets.Dammyimages),
                                    fit: BoxFit.cover,
                                  ),
                                  */
                              Image.network(imageUserProfileLogo.toString(),
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
                  )),
            ),

            SizedBox(
              height: 30,
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
                      SizedBox(height: 10,),
                      Text(nameUserProfileLogo ??"",style: TextStyle(color: AppColors.black,),),

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
                      SizedBox(height: 10,),
                      Text(firstNameUserProfileLogo ?? "",style: TextStyle(color: AppColors.black,),),

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
                      SizedBox(height: 10,),
                      Text(lastNameUserProfileLogo ?? "",style: TextStyle(color: AppColors.black,),),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 15,),
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
                      SizedBox(height: 10,),
                      Text(genderUserProfileLogo ?? "",style: TextStyle(color: AppColors.black,),),

                     /* Container(
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
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10),
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
                      SizedBox(height: 10,),
                      Text(dateOfBirthUserProfileLogo ?? "",style: TextStyle(color: AppColors.black,),),

               /*       Container(
                        margin: EdgeInsets.only(top: 15),
                        height: 25,
                        width: MediaQuery.of(context).size.width - 80,
                        child: TextField(
                          controller: dateInput,
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.edit,size: 20,),
                              border: InputBorder.none,
                              hintText: "Enter Date"
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
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }

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
              /*    Container(
                    //   height: textMaxLine == 1 ? 35 :MediaQuery.of(context).size.height/2,
                    alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      description,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors
                              .black),
                  maxLines: textMaxLine== 1 ? 2 : 100 ,
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
}
