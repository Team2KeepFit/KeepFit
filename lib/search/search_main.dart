import 'package:flutter/material.dart';
import 'package:keepfit/search/search.dart';

class Search_Main extends StatelessWidget {
  const Search_Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeepFit',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage1(),
    );
  }
}
