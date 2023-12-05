import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:schatbooks/view/splash_screen.dart';

import 'Services/notification_service.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? sharePref;
// Future<void> backgroundHandler(RemoteMessage message)async{
//   String? title=message.notification!.title;
//   String? body=message.notification!.body;
//
//   AwesomeNotifications().createNotification(content: NotificationContent(id: 3, channelKey:"basic key",title: "Hello",
//       displayOnBackground: true,displayOnForeground: true,body: "Hello world!!",
// color: Colors.green,
//       category: NotificationCategory.Service,
//       wakeUpScreen: true,
//       fullScreenIntent: true,
//       backgroundColor: Colors.orange,
//       autoDismissible: true),
//
//   actionButtons: [
//
//
//     NotificationActionButton(key: "Accept", label: "Add friend",color: Colors.blue,autoDismissible: true),
//     NotificationActionButton(key: "DISMISS", label: "Dismiss",color: Colors.black54,autoDismissible: true),
//
//
//
//
//   ]);
//
//
//
// }
void main() async {
  await NotificationService.initializeNotification();
  WidgetsFlutterBinding.ensureInitialized();
  sharePref = await SharedPreferences.getInstance();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await _initFirebase();
// await initServices();

  runApp(ProviderScope(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: "CrimsonText",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      // initialBinding: Binding(),

      getPages: [
        GetPage(
          name: "/",
          page: () => const splash(),
        )
      ],
    ),
  ));
}

_initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
// Future initServices()async{
//   await Get.putAsync(() => APIs().getAllposts());
//
//
// }
