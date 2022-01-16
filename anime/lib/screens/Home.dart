import 'package:anime/models/questionList.dart';
import 'package:anime/widgets/quiz.dart';
import 'package:anime/widgets/variant.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static QuestionList questionList = QuestionList();
  Variant variant = Variant();

  void result() {
    int score = questionList.getScore();
    int questionsNumber = questionList.getQuestionNumber();
    Alert(
      context: context,
      title: "Finished",
      desc: "You have taked $score from $questionsNumber",
      buttons: [
        DialogButton(
          child: Text(
            "Try Again!",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              questionList = QuestionList();
              questionList.nextQuestionAppear();
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: ListView(
          children: <Widget>[
            QuestionScreen(
              questionList: questionList,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        questionList = QuestionList();
                        questionList.nextQuestionAppear();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width - 90) / 2,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(128, 128, 128, 0.4),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Quit quiz',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (!questionList.isLastQuestion()) {
                          questionList.nextQuestion();
                          questionList.questionNotAnswered();
                          questionList.nextQuestionAppear();
                        } else {
                          result();
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      width: (MediaQuery.of(context).size.width - 90) / 2,
                      decoration: BoxDecoration(
                        color: Colors.blue[300],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
