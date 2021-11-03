import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keepfit/Planner/plan_disp.dart';
import 'package:keepfit/Planner/schedule.dart';

void plandisp(BuildContext context, {required List<Map<String, dynamic>> para}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => DisplayPlan(para: para),
  ));
}

void scheduledisp(BuildContext context, {required Map<String, dynamic> para}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => DisplaySchedule(para: para),
  ));
}
//animation

class Result extends StatefulWidget {
  final List resultScore;
  final VoidCallback resetHandler;
  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  List get resultScore {
    return widget.resultScore;
  }

  VoidCallback get resetHandler {
    return widget.resetHandler;
  }

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

  Widget general(Map<String, dynamic> schedule,
      List<Map<String, dynamic>> exercises, int tt) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            children: <Widget>[
              OutlinedButton(
                onPressed: () => {plandisp(context, para: exercises)},
                onLongPress: () => {scheduledisp(context, para: schedule)},
                style: OutlinedButton.styleFrom(
                  elevation: 5.0,
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(28.0)),
                  side: const BorderSide(color: Colors.black),
                ),
                child: Text(
                  resultPhrase,
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      color: Colors.teal),
                  textAlign: TextAlign.center,
                ),
              ),
              const Tooltip(
                  message:
                      "Short Press for Exercises! Long Press for Schedule!",
                  triggerMode: TooltipTriggerMode.tap,
                  child: FaIcon(FontAwesomeIcons.infoCircle,
                      color: Colors.black45,size:20.0)),
              TextButton(
                child: const Text('Restart Quiz!',
                    style: TextStyle(color: Colors.blue)), //Text
                onPressed: resetHandler,
              ), //FlatButton
            ],
          ),
        ], //<Widget>[]
      ), //Column
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("Plans")
            .doc(resultPhrase)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error in fetching Data!!",
                  style: TextStyle(height: 5, fontSize: 10)),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            ));
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          Map<String, dynamic> schedule = data['Schedule'];
          List<Map<String, dynamic>> exercises = [];
          for (var element in data.keys) {
            if (element != 'Schedule' &&
                element != 'Total Time(per day in mins)') {
              exercises.add(data[element]);
            }
          }
          int tt = data['Total Time(per day in mins)'];
          return general(schedule, exercises, tt);
        });
  }
}
