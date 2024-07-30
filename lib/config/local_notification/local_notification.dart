import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../router/route.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

Future<void> intializeNotification() async {
  await _flutterLocalNotificationInitialization();
  _requestNotificationPermission();
  _selectNotificationListenerHandler();
}

Future<void> _flutterLocalNotificationInitialization() async {
  print('flutterlocalnotifinitialize');
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
        if (payload == 'goToAlarm') {
          selectNotificationStream.add(payload);
        } else {

          selectNotificationStream.add(payload);
        }
      } 
    },
  );
}

void _requestNotificationPermission() {
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();
}



void _selectNotificationListenerHandler() {
  selectNotificationStream.stream.listen((payload) async { 
    log('[_selectNotificationListenerHandler] $payload');

    // context.goNamed(AppPage.alarm);
    AppRoute.router.goNamed(AppPage.alarm);
  });
}


@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('notificationTapBackground');
  log('notificationTapBackground');
  inspect(notificationResponse);
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
  log("_onDidReceiveBackgroundNotificationResponse");
  final String? payload = details.payload;

  if (payload != null) {
    log('Ini payloadnya : $payload');
  } 
}