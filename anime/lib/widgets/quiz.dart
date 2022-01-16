import 'package:anime/widgets/progress_bar.dart';
import 'package:anime/widgets/txt.dart';
import 'package:anime/widgets/variant.dart';
import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final questionList;
  final icons;

  const QuestionScreen({Key key, this.questionList, this.icons});
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  void answerPressed() {
    setState(() {
      widget.questionList.questionAnswered();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Txt(
                    title: widget.questionList.quizType(),
                    color: Colors.grey,
                    fontSize: 15),
                Row(
                  children: <Widget>[
                    Txt(title: 'Question', color: Colors.white, fontSize: 35),
                    Txt(
                        title:
                            widget.questionList.getQuestionNumber().toString(),
                        color: Colors.white,
                        fontSize: 35),
                    Txt(
                        title: "/" +
                            widget.questionList.questionsLength().toString(),
                        color: Colors.grey,
                        fontSize: 35),
                  ],
                ),
                ProgressBar(questionList: widget.questionList),
                Txt(
                  title: widget.questionList.getQuestionText(),
                  color: Colors.grey,
                  fontSize: 28,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ...widget.questionList
              .variants()
              .map(
                (v) => Variant(
                  title: v['answer'],
                  isCorrect: v.containsKey('isCorrect') ? true : false,
                  onTapVariant: () {
                    answerPressed();
                  },
                  questionList: widget.questionList,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
