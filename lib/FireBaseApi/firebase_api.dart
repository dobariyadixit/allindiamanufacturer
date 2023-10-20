import 'package:allindiamanufacturer/Screen/NoticationScreen/NotifactionScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:pushnotificationdemo/Screen/NotifactionScreen.dart';
//import 'package:pushnotificationdemo/main.dart';

import '../main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title : ${message.notification!.title}');
  print('Body : ${message.notification!.body}');
  print('Payload : ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorkey.currentState?.pushNamed(
      NotifactionScreen.route,
      arguments: message,
    );
  }

  Future initPushNotification()async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  }

  Future<void> initNotifiction() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token : $fCMToken');
    print('ffffffffffffffffffffffffffffffffffffff');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotification();
  }



}
