import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final List resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

  //Remark Logic
  String get resultPhrase {
    String resultText;
    if (resultScore[0]==1) {
      resultText = 'Full Body Basic';
      print(resultScore);
    } else if (resultScore[1]==2) {
      resultText = 'Bro Split';
      print(resultScore);
    } else if (resultScore[1]==0 && resultScore[2]==0) {
      resultText = 'Full Body Basic';
    } else if (resultScore[1]==0 && (resultScore[2]==1 || resultScore[2]==2)) {
      resultText = 'Full Body Advanced';
    } else if (resultScore[1]==1 && (resultScore[2]==1 || resultScore[2]==0)){
      resultText = 'Upper - Lower Split';
      print(resultScore);
    }else if (resultScore[1]==1 && resultScore[2]==2) {
      resultText = 'Full Body Advanced';
      print(resultScore);
    }else if(resultScore[1]==3 && resultScore[2]==0){
      resultText='Bro Split Advanced';
      print(resultScore);
    }else{
      resultText='Push-Pull-Leg Split';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ), //Text
          FlatButton(
            child: Text(
              'Restart Quiz!',
            ), //Text
            textColor: Colors.blue,
            onPressed: resetHandler,
          ), //FlatButton
        ], //<Widget>[]
      ), //Column
    ); //Center
  }
}