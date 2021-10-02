import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:keepfit/utilites/quiz.dart';
import 'package:keepfit/utilites/result.dart';

/*void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}*/

class Planner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<Planner> {
  final _questions = const [
    {
      'questionText': 'Q1. What is your experience wrt any form of resistance training?',
      'answers': [
        {'text': '> 6 months', 'score': 0},
        {'text': '<= 6 months', 'score': 1},
      ],
    },
    {
      'questionText': 'Q2. How many days you can allocate for exercising for a week?',
      'answers': [
        {'text': '3 days', 'score': 0},
        {'text': '4 days', 'score': 1},
        {'text': '5 days', 'score': 2},
        {
          'text':
          '6 days',
          'score': 3
        },
      ],
    },
    {
      'questionText': ' Q3. How much time you can spend for exercising on each allocated day?',
      'answers': [
        {'text': '30 mins', 'score': 0},
        {'text': '45 mins', 'score': 1},
        {'text': '60-75 mins', 'score': 2},
      ],
    },
  ];

  var _questionIndex = 0;
  var _decisioncriteria=List.empty(growable: true);

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _decisioncriteria = [];
    });
  }

  void answerQuestion(int score) {
    if(_questionIndex==0 && score==1)
    {
      _decisioncriteria.add(score);
      setState(() {
        _questionIndex = _questions.length;
      });
    }
    else if(_questionIndex==1 && score==2)
    {
      _decisioncriteria.add(score);
      setState(() {
        _questionIndex = _questions.length;
      });
    }
    else
    {
      _decisioncriteria.add(score);
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
    }
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      print('We have more questions!');
    } else {
      print('No more questions!');
    }
  }

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
            onPressed: () => {},
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
            answerQuestion: answerQuestion,
            questionIndex: _questionIndex,
            questions: _questions,
          ) //Quiz
              : Result(_decisioncriteria, _resetQuiz),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
