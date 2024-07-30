import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:alarm_app/app.dart';
import 'package:alarm_app/config/local_notification/android_channel_notification.dart';
import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:timezone/timezone.dart' as tz;

import '../config/local_notification/local_notification.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Halo'),
            ElevatedButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  showBasicNotification();
                }
              }, 
              child: Text('Show Basic Notification')
            ),
            ElevatedButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  scheduleAlarm(Duration(seconds: 10));
                }
              }, 
              child: Text('Schedule alarm for 10 second')
            ),

            ElevatedButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  scheduleAlarm(Duration(minutes: 1));
                }
              }, 
              child: Text('Schedule alarm for 1 minute')
            ),

          ],
        ),
      ),
    );
  }
}

Future<void> showBasicNotification() async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    basicChannelId, 
    basicChannelName,
    channelDescription: basicChannelDescription,
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
    ticker: 'ticker'
  );

  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
    notificationId, 
    'Basic Notification', 
    'Showing Basic Notification', 
    notificationDetails,
    payload: 'ANDROID'
  );

  notificationId++ ;
}

Future<void> scheduleAlarm(Duration duration) async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestFullScreenIntentPermission();
  log('scheduling alarm...');
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    alarmChannelId, 
    alarmChannelName,
    channelDescription: alarmChannelDescription,
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker',
    fullScreenIntent: true,
    playSound: false
  );

  final notificationDetails = NotificationDetails(android: androidNotificationDetails);

  await flutterLocalNotificationsPlugin.zonedSchedule(
    notificationId, 
    'Alarm Notification', 
    'This is fullscreen notification / alarm notification', 
    tz.TZDateTime.now(tz.local).add(duration), 
    notificationDetails, 
    uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    payload: 'goToAlarm'
  );

  notificationId++;
}

// Future<void> launchAlarmActiviy() async {
//   AndroidIntent intent = AndroidIntent(
//       package: 'com.example.alarm_app',
//       componentName: 'com.example.alarm_app.AlarmActivity'
//   );
//   await intent.launch();
// }