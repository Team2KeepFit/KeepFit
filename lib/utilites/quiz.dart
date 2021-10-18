import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    Key?key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(duration: const Duration(milliseconds: 500),
          child: Wrap(key: ValueKey<String>('${questions[questionIndex]["questionText"]}'),
          children: [
          Question(
          '${questions[questionIndex]["questionText"]}',
          ), //Question ,
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score']), '${answer["text"]}');
        }).toList()],
          ),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final inAnimation =
            Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);
            final outAnimation =
            Tween<Offset>(begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation);

            if (child.key == ValueKey('${questions[questionIndex]["questionText"]}')) {
              return ClipRect(
                child: SlideTransition(
                  position: inAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child,
                  ),
                ),
              );
            } else {
              return ClipRect(
                child: SlideTransition(
                  position: outAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: child,
                  ),
                ),
              );
            }
          },
        ),
      ],
    ); //Column
  }
}
