import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplaySchedule extends StatelessWidget {
  final String para;
  const DisplaySchedule({required this.para, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        // <2> Pass `Future<QuerySnapshot>` to future
        future: FirebaseFirestore.instance.collection('Plans').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'KeepFit',
                    textAlign: TextAlign.center,
                  ),
                  elevation: 2.0,
                  leading: BackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                      children: documents
                          .map((doc) => Card(
                                child: ListTile(
                                  title: const Text('Schedule'),
                                  subtitle: Text(
                                      doc[para]['Schedule']),
                                ),
                              ))
                          .toList()),
                ),
              ),
              debugShowCheckedModeBanner: false,
            );
          }
          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'KeepFit',
                  textAlign: TextAlign.center,
                ),
                elevation: 2.0,
                leading: BackButton(
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: const Padding(
                padding: EdgeInsets.all(30.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}
