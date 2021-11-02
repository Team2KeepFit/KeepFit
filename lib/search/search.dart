import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'KeepFit',
            textAlign: TextAlign.center,
          ),
          elevation: 2.0,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomepageState createState() => _MyHomepageState();
}
class _MyHomepageState extends State<MyHomePage> {


  void search_data(String value,AsyncSnapshot snapshot)
  {
    var x=snapshot.data!.docs;
    print("${x.runtimeType}");
  }
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("Search").get(),
      builder:(context,snapshot){
        return ListView(
          children: [
            Container(
              child: TextFormField(
                onChanged: (value){
                  search_data(value,snapshot);
                },
                decoration: const InputDecoration(
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search)
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}


