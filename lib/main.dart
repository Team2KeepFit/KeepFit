import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keepfit/homepage.dart';
import 'app/sign_in/sign_in_page.dart';
import 'feedback/options/options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeepFit',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      //home: Feedbac(),
      //home: SignInPage(),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      //home: Issue(),
      //home: Exercise(),
    );
  }
}

