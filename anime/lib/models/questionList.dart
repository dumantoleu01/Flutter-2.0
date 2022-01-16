import 'package:anime/models/question.dart';
import 'package:flutter/material.dart';

class QuestionList {
  int _questionNumber = 0;
  int _score = 0;
  bool _isQuestionAnswered = false;
  bool _nextQuestionAppear = false;
  bool resetIcons = false;

  var icons = [
    Icon(
      Icons.horizontal_rule,
      color: Colors.grey,
    ),
    Icon(
      Icons.horizontal_rule,
      color: Colors.grey,
    ),
    Icon(
      Icons.horizontal_rule,
      color: Colors.grey,
    ),
    Icon(
      Icons.horizontal_rule,
      color: Colors.grey,
    ),
    Icon(
      Icons.horizontal_rule,
      color: Colors.grey,
    ),
  ];

  void correctAnsIcon() {
    icons[_questionNumber] = Icon(
      Icons.horizontal_rule,
      color: Colors.green,
    );
  }

  void wrongAnsIcon() {
    icons[_questionNumber] = Icon(
      Icons.horizontal_rule,
      color: Colors.red,
    );
  }

  void notAnsIcon() {
    icons.map((i) => i = Icon(
          Icons.horizontal_rule,
          color: Colors.grey,
        ));
    print('icons deleated');
    resetIcons = true;
  }

  final _questionList = [
    Question(
      title: '..... Caviar in the fridge.',
      answers: [
        {
          'answer': 'There is not no  ',
        },
        {
          'answer': 'There is any',
        },
        {'answer': 'There is not any', 'isCorrect': 1},
        {
          'answer': 'There are not no',
        }
      ],
      index: 1,
      typeQuiz: 'Naruto Quiz',
    ),
    Question(
      title: 'He goes to his guitar lessons....',
      answers: [
        {'answer': 'by underground', 'isCorrect': 1},
        {
          'answer': 'on underground  ',
        },
        {
          'answer': 'with underground',
        },
        {
          'answer': 'in underground',
        },
      ],
      index: 2,
      typeQuiz: 'Naruto Quiz',
    ),
    Question(
      title: 'David is the boss, you need to speak to ...',
      answers: [
        {
          'answer': 'it',
        },
        {'answer': 'him', 'isCorrect': 1},
        {
          'answer': 'her',
        },
        {
          'answer': 'them',
        },
      ],
      index: 3,
      typeQuiz: 'Naruto Quiz',
    ),
    Question(
      title: 'She ... Supper with us last Friday',
      answers: [
        {
          'answer': 'had not',
        },
        {
          'answer': 'no had',
        },
        {
          'answer': 'did not have got',
        },
        {'answer': 'did not have', 'isCorrect': 1},
      ],
      index: 4,
      typeQuiz: 'Naruto Quiz',
    ),
    Question(
      title: 'She ... Supper with us last Friday',
      answers: [
        {
          'answer': 'had not',
        },
        {
          'answer': 'no had',
        },
        {
          'answer': 'did not have got',
        },
        {'answer': 'did not have', 'isCorrect': 1},
      ],
      index: 5,
      typeQuiz: 'Naruto Quiz',
    ),
  ];

  Question question() {
    return _questionList[_questionNumber];
  }

  String getQuestionText() {
    return _questionList[_questionNumber].title;
  }

  bool isLastQuestion() {
    return _questionNumber == _questionList.length - 1;
  }

  void resetQuestionNumber() {
    _questionNumber = 0;
  }

  void correct() {
    _score++;
  }

  int getScore() {
    return _score;
  }

  void resetScore() {
    _score = 0;
  }

  void nextQuestion() {
    _questionNumber++;
  }

  int getQuestionNumber() {
    return _questionNumber + 1;
  }

  int questionsLength() {
    return _questionList.length;
  }

  List<Map> variants() {
    return _questionList[_questionNumber].answers;
  }

  String quizType() {
    return _questionList[_questionNumber].typeQuiz;
  }

  void questionAnswered() {
    _isQuestionAnswered = true;
  }

  void questionNotAnswered() {
    _isQuestionAnswered = false;
  }

  bool isQuestionAnswered() {
    return _isQuestionAnswered;
  }

  void nextQuestionAppear() {
    _nextQuestionAppear = true;
  }

  void nextQuestionDisappear() {
    _nextQuestionAppear = false;
  }

  bool isNextQuestionAppear() {
    return _nextQuestionAppear;
  }
}
