import 'dart:io';
import 'package:allindiamanufacturer/FireBaseApi/firebase_api.dart';
import 'package:allindiamanufacturer/Screen/SpashScreen/SpashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class PostHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

final navigatorkey = GlobalKey<NavigatorState>();

Future<void> main() async {
  HttpOverrides.global = new PostHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await FirebaseApi().initNotifiction();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: navigatorkey,
      theme: ThemeData(
 /*       bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.transparent),*/
       // useMaterial3: true,
      ),
      home: SpashScreen(),
    );
  }
}

