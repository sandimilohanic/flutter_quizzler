import 'Question.dart';

class QuestionBank {
  int _questionNumber = 0;

  List<Question> _questionList = [
    Question("You can lead a cow down stairs but not up stairs.", false),
    Question("Approximately one quarter of human bones are in the feet.", true),
    Question("A slug\'s blood is green.", true),
  ];

  Question getQuestion() {
    return _questionList[_questionNumber];
  }

  String getQuestionText() {
    return _questionList[_questionNumber].questionText;
  }

  bool getQuestionAnswer() {
    return _questionList[_questionNumber].questionAnswer;
  }

  int getTotalQuestions() {
    print(_questionList.length);
    return _questionList.length;
  }

  bool isFinished() {
    return _questionNumber == getTotalQuestions() - 1;
  }

  int getQuestionNumber() {
    return _questionNumber;
  }

  void reset() {
    _questionNumber = 0;
  }

  void nextQuestion() {
    if (_questionNumber < _questionList.length) {
      _questionNumber++;
    }
  }
}
