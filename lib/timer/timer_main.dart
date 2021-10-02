import 'package:flutter/material.dart';
import 'package:keepfit/timer/timer_ac.dart';

class Timer extends StatelessWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: timer_home_page(),
    );
  }
}
