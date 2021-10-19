import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keepfit/Planner/plan_disp.dart';
import 'package:keepfit/Planner/schedule.dart';

void plandisp(BuildContext context, {required String para}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => DisplayPlan(para: para),
  ));
}

void scheduledisp(BuildContext context, {required String para}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => DisplaySchedule(para: para),
  ));
}
//animation

class Result extends StatefulWidget {
  final List resultScore;
  final VoidCallback resetHandler;
  const Result(this.resultScore, this.resetHandler,{Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List get resultScore{
    return widget.resultScore;
  }
  VoidCallback get resetHandler{
    return widget.resetHandler;
  }
  var _schedule;

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore[0] == 1) {
      resultText = 'Full Body Basic';
    } else if (resultScore[1] == 2) {
      resultText = 'Bro Split';
    } else if (resultScore[1] == 0 && resultScore[2] == 0) {
      resultText = 'Full Body Basic';
    } else if (resultScore[1] == 0 &&
        (resultScore[2] == 1 || resultScore[2] == 2)) {
      resultText = 'Full Body Advanced';
    } else if (resultScore[1] == 1 &&
        (resultScore[2] == 1 || resultScore[2] == 0)) {
      resultText = 'Upper - Lower Split';
    } else if (resultScore[1] == 1 && resultScore[2] == 2) {
      resultText = 'Full Body Advanced';
    } else if (resultScore[1] == 3 && resultScore[2] == 0) {
      resultText = 'Bro Split Advanced';
    } else {
      resultText = 'Push-Pull-Leg Split';
    }
    return resultText;
  }
  void Schedule()
  {
    CollectionReference collectionreference = FirebaseFirestore.instance.collection('Plans');
    collectionreference.snapshots().listen((snapshot){
      setState(() {
        List Docux=snapshot.docs;
        int p=Docux.indexOf(resultPhrase);
        Map<String,dynamic> aller = Docux[p];
        _schedule=aller['Schedule'];
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: ()=>{plandisp(context,para:resultPhrase)},
            child: Text(
              resultPhrase+'->',
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color:Colors.black),
              textAlign: TextAlign.center,
            ),
          ), //Text
          TextButton(
            onPressed: ()=>{plandisp(context,para:resultPhrase)},
            child: const Text(
              'Schedule->',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color:Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            child: const Text(
                'Restart Quiz!',
                style: TextStyle(color: Colors.blue)
            ), //Text
            onPressed: resetHandler,
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    );
  }
}
