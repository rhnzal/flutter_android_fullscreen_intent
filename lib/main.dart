import 'package:alarm_app/app.dart';
import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'config/local_notification/local_notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  await intializeNotification();

  await initializeRouteHandler();

  runApp(AlarmApp());
}