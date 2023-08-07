import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';
import 'package:quiz_app/quiz.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({
    super.key,
    required this.choosenAnswer,
  });

  final List<String> choosenAnswer;

  List<Map<String, Object>> getSumarry() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < choosenAnswer.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': choosenAnswer[i],
      });
    }

    return summary;
  }

  @override
  Widget build(context) {
    final summaryData = getSumarry();
    final numOfTotalAnswer = questions.length;
    final numOfCorrectanswer = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have answered $numOfCorrectanswer out of $numOfTotalAnswer questions correctly!',
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Quiz()));
              },
              child: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
