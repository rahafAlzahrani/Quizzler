import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    //get correct answer from quizBank list
    bool correctAnswers = quizBrain.getCorrectAnswer();
    setState(() {
      //check if we've reached the end of the quiz.
      if (quizBrain.isFinished() == true) {
        //show an alert using rFlutter_alert,
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          style: AlertStyle(
            backgroundColor: Color(0xff6067d0),
            titleStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            descStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          buttons: [
            DialogButton(
              color: Color(0xffff7d00),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();
        //reset the questionNumber,
        quizBrain.reset();
        //empty out the scoreKeeper.
        scoreKeeper = [];
        //If we've not reached the end, ELSE do the answer checking steps below
      } else {
        if (userPickedAnswer == correctAnswers) {
          print('user got it right!');
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          print('user got it wrong!');
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  FlatButton buildButton({bool answer, Color buttonColor, String buttonText}) {
    return FlatButton(
      onPressed: () {
        checkAnswer(answer);
      },
      child: Container(
        margin: answer == true
            ? EdgeInsets.only(left: 20)
            : EdgeInsets.only(right: 20),
        height: 70,
        width: 130,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.25),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(3, 3), // changes position of shadow
            ),
          ],
        ),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      color: Color(0xff6067d0),
      constraints: BoxConstraints.expand(),
      padding: EdgeInsets.only(
        top: 100.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //hold the question
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 20,
            ),
            padding: EdgeInsets.all(10),
            height: 400,
            width: size.width - 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 30,
                  offset: Offset(14, 14), // changes position of shadow
                ),
              ],
            ),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xffff7d00),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          //hold true and false buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //button True
              buildButton(
                  answer: true,
                  buttonColor: Colors.lightGreen,
                  buttonText: 'True'),
              buildButton(
                  answer: false, buttonColor: Colors.red, buttonText: 'False'),
              //button false
            ],
          ),
          SizedBox(
            height: 10,
          ),
          //hold true false  icons based on the user answer.
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}
