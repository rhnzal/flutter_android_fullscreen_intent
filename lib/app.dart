import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: AppRoute.router,
    );
  }
}