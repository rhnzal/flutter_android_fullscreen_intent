import 'dart:io';

import 'package:alarm_app/config/local_notification/local_notification.dart';
import 'package:alarm_app/screen/alarm_screen.dart';
import 'package:alarm_app/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static late GoRouter router;

  static initialize(String initialLocation) {
    router = GoRouter(
      initialLocation: initialLocation,

      routes: [
        GoRoute(
          path: '/home',
          name: AppPage.home,
          pageBuilder: (context, state) => CupertinoPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/alarm',
          name: AppPage.alarm,
            pageBuilder: (context, state) => CupertinoPage(child: AlarmScreen())
        )
      ]
    );
  }

}

class AppPage {
  static const String home = 'home';
  static const String alarm = 'alarm';
}

Future<void> initializeRouteHandler() async {
  String initialLocation = '/home';

  final NotificationAppLaunchDetails? notificationAppLaunchDetails = !kIsWeb && Platform.isLinux ? null :
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    if (notificationAppLaunchDetails?.notificationResponse?.payload == 'goToAlarm') {
      initialLocation = '/alarm';
      print('initialiRoute: $initialLocation');
    }
  }

  AppRoute.initialize(initialLocation);
}