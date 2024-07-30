import 'dart:developer';

import 'package:alarm_app/config/router/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.setAudioSource(AudioSource.asset('assets/audio/alarm.wav'));
    player.setLoopMode(LoopMode.all);
    player.play();
  }

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
                log('dismissing alarm');
                player.stop();
                SystemNavigator.pop();
              }, 
              child: Text('Dismiss Alarm')
            ),
          ],
        ),
      ),
    );
  }
}