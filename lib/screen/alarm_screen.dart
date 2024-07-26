import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlarmScreen extends StatelessWidget {
  const AlarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Alarm Page'),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppPage.home);
              }, 
              child: Text('Dismiss Alarm')
            ),
          ],
        ),
      ),
    );
  }
}