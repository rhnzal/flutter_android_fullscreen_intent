import 'package:alarm_app/screen/alarm_screen.dart';
import 'package:alarm_app/screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRoute {
  static GoRouter router = GoRouter(
    initialLocation: '/home',

    routes: [
      GoRoute(
        path: '/home',
        name: AppPage.home,
        pageBuilder: (context, state) => CupertinoPage(child: HomeScreen()),
        // routes: [
        //   GoRoute(
        //     path: 'alarm',
        //     name: AppPage.alarm,
        //     pageBuilder: (context, state) => CupertinoPage(child: AlarmScreen())
        //   )
        // ]
      ),
      GoRoute(
        path: '/alarm',
        name: AppPage.alarm,
          pageBuilder: (context, state) => CupertinoPage(child: AlarmScreen())
      )
    ]
  );
}

class AppPage {
  static const String home = 'home';
  static const String alarm = 'alarm';
}