import 'dart:async';
import 'dart:developer';

import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

@pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  log("_onDidReceiveBackgroundNotificationResponse");
  final String? payload = details.payload;

  if (payload != null) {
    log('Ini payloadnya : $payload');
  } 
}

class AlarmApp extends StatefulWidget {
  const AlarmApp({super.key});

  @override
  State<AlarmApp> createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {

  @override
  void initState() {
    super.initState();

    initialSetup();
  }

  Future<void> initialSetup() async {
    await _flutterLocalNotificationInitialization();
    _requestNotificationPermission();
  }



  Future<void> _flutterLocalNotificationInitialization() async {
    var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,

      onDidReceiveNotificationResponse: (details) {
        log("_onDidReceiveNotificationResponse");
        final String? payload = details.payload;

        if (payload != null) {
          log('Ini payloadnya : $payload');
        } 

        context.goNamed(AppPage.alarm);
      },
    );
  }

  void _requestNotificationPermission() {
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: AppRoute.router,
    );
  }
}