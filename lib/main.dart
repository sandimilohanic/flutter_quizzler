import 'package:flutter/material.dart';
import 'package:quizzler/models/Question.dart';

import '/models/QuestionBank.dart';

QuestionBank questionBank = QuestionBank();
void main() => runApp(
      Quizzler(),
    );

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreCheck = [];
  double indicatorValue = 0;

  void addScoreProgress(IconData _icon, Color _color) {
    setState(() {
      scoreCheck.add(
        Icon(
          _icon,
          color: _color,
        ),
      );
    });
  }

  void checkQuestionStatus(bool status) {
    Question q = questionBank.getQuestion();
    addScoreProgress(status == q.questionAnswer ? Icons.check : Icons.close,
        status == q.questionAnswer ? Colors.green : Colors.red);

    setState(() {
      indicatorValue = 1 /
          ((questionBank.getTotalQuestions() -
              questionBank.getQuestionNumber()));
    });
    questionBank.nextQuestion();
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Visibility(
              visible: !questionBank.isFinished(),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  'True',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkQuestionStatus(true);
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Visibility(
              visible: !questionBank.isFinished(),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  checkQuestionStatus(false);
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: questionBank.isFinished(),
          child: Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  'Start again',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  questionBank.reset();
                },
              ),
            ),
          ),
        ),
        Row(
          children: scoreCheck,
        ),
        SizedBox(
          height: 10,
        ),
        LinearProgressIndicator(
          value: indicatorValue,
          minHeight: 8,
          backgroundColor: Colors.grey,
          color: Colors.blue[900],
        )
      ],
    );
  }
}
