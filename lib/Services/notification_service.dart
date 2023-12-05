import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class NotificationService{
  static Future<void> initializeNotification()async{



    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelGroupKey: 'high_importance_channel',
          channelKey: "high_importance_channel",
          channelName: "Basic_notification",
          channelDescription: "notification for test",
          ledColor: Colors.white,
          defaultColor: Colors.blue,
          importance: NotificationImportance.Max,
          playSound: true,
          // locked: true,
          onlyAlertOnce: true,
          criticalAlerts: true,
          channelShowBadge: true)
    ], debug: true, channelGroups: [
      
      NotificationChannelGroup(channelGroupKey: 'high_importance_channel', channelGroupName: 'Group 1',


      )
      
    ]);
    await  AwesomeNotifications().isNotificationAllowed().then((isAllowed) async{

      if(!isAllowed){
      await  AwesomeNotifications().requestPermissionToSendNotifications();


      }

    });
    
    await  AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod,
        onNotificationCreatedMethod: onNotificationCreatedMethod,
        onNotificationDisplayedMethod: onNotificationDisplayedMethod,
        onDismissActionReceivedMethod: onDismissActionReceivedMethod );




  }
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification)async {
    debugPrint('onNotificationCreatedMethod');
  }
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification)async {
    debugPrint('onNotificationDisplayedMethod');
  }

  static Future<void> onDismissActionReceivedMethod(ReceivedNotification receivedNotification)async {
    debugPrint('onDismissActionReceivedMethod');
  }
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction)async {
    debugPrint('onActionReceivedMethod');
    final payload=receivedAction.payload??{};

    if(payload["navigate"]=="true"){
      // Get.to();
    }
  }

  static Future<void> showNotification({

    required final String title,
    required final String body,
    final String? summry,
    final Map<String,String>? payload,
    final ActionType actionType=ActionType.Default,
    final NotificationLayout notificationLayout= NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled=false,
    final int? interval,
    final String? imageProfile


  }) async{

assert(!scheduled|| (scheduled && interval!=null));
await AwesomeNotifications().createNotification(content: NotificationContent(id: 1,
  channelKey:'high_importance_channel',
  title: title,
  body: body,
showWhen: true,
  autoDismissible: true,
  roundedBigPicture: true,
  actionType: actionType,
  notificationLayout: notificationLayout,
  displayOnBackground: true,
  displayOnForeground: true,
  summary: summry,
  color: Colors.blue,
  largeIcon:imageProfile,
  roundedLargeIcon: true,
  hideLargeIconOnExpand: false,
   criticalAlert: true,

  category: category,
  payload: payload,
  bigPicture: bigPicture,

),
actionButtons: actionButtons,
    schedule: scheduled?

    NotificationInterval(interval: interval
        ,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),preciseAlarm: true):null,

);


}

}