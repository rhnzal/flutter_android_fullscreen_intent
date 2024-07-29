import 'dart:io';

import 'package:alarm_app/app.dart';
import 'package:alarm_app/config/local_notification/android_channel_notification.dart';
import 'package:alarm_app/config/router/route.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

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
                  scheduleAlarm();
                }
              }, 
              child: Text('Schedule alarm for 10 second')
            ),

            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPage.alarm);
              }, 
              child: Text('Navigate to alarm page')
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

Future<void> scheduleAlarm() async {
  print('alarm set');
  await Future.delayed(Duration(seconds: 10));

  print('showing alarm');
  launchAlarmActiviy();
}

Future<void> launchAlarmActiviy() async {
  AndroidIntent intent = AndroidIntent(
      package: 'com.example.alarm_app',
      componentName: 'com.example.alarm_app.AlarmActivity'
  );
  await intent.launch();
}