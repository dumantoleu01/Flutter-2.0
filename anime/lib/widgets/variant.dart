import 'package:anime/constants.dart';
import 'package:flutter/material.dart';

class Variant extends StatefulWidget {
  final String title;
  final bool isCorrect;
  final Function onTapVariant;
  final questionList;

  const Variant({
    Key key,
    this.title,
    this.isCorrect,
    this.onTapVariant,
    this.questionList,
  });

  @override
  _VariantState createState() => _VariantState();
}

class _VariantState extends State<Variant> {
  IconData _iconVariant = Icons.circle_outlined;
  Color _color = standartColor;
  Color _borderColor = standartColor;
  Color _insideBorderColor = null;
  Color _fontColor = standartColor;

  void pressedNextButton() {
    _iconVariant = Icons.circle_outlined;
    _color = standartColor;
    _borderColor = standartColor;
    _insideBorderColor = null;
    _fontColor = standartColor;
  }

  void checkAnswer(ans) {
    if (ans) {
      _iconVariant = Icons.check_circle;
      _color = trueAnswer;
      _insideBorderColor = insideBorderColorWrong;
      _borderColor = borderColorTrue;
      _fontColor = trueAnswer;
      widget.questionList.correct();
      widget.questionList.correctAnsIcon();
      print('2');
    } else {
      _iconVariant = Icons.close;
      _color = wrongAnswer;
      _insideBorderColor = insideBorderColorTrue;
      _borderColor = borderColorWrong;
      _fontColor = wrongAnswer;
      widget.questionList.wrongAnsIcon();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.questionList.isNextQuestionAppear()) {
      pressedNextButton();
      print('1');
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!widget.questionList.isQuestionAnswered()) {
            checkAnswer(widget.isCorrect);
            widget.onTapVariant();
            widget.questionList.nextQuestionDisappear();
            print('3');
          }
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: widget.questionList.isQuestionAnswered()
                  ? (widget.isCorrect
                      ? Color.fromRGBO(0, 200, 0, 0.5)
                      : _insideBorderColor)
                  : _insideBorderColor,
              border: Border.all(color: _borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: widget.questionList.isQuestionAnswered()
                          ? (widget.isCorrect
                              ? Color.fromRGBO(0, 200, 0, 0.5)
                              : _fontColor)
                          : _fontColor,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  _iconVariant,
                  size: 15,
                  color: widget.questionList.isQuestionAnswered()
                      ? (widget.isCorrect
                          ? Color.fromRGBO(0, 200, 0, 0.5)
                          : _color)
                      : _color,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
