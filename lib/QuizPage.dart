import 'package:flutter/material.dart';
import 'package:quizzler/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // This is variable to track whether the (F/T) button pressed or not.
  //var pressed = false;

  // This is function to change the color of (F/T) button when pressed.
  //void whenPressed() {}
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          //hold the question
          Container(
            margin: EdgeInsets.only(
              left: 30,
              right: 30,
              bottom: 20,
            ),
            padding: EdgeInsets.all(2),
            height: 300,
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
            height: 10,
          ),
          //hold true and false buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //button True
              TextButton(
                onPressed: () {
                  checkAnswer(true);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  height: 70,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
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
                      'True',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
              //button false
              TextButton(
                onPressed: () {
                  checkAnswer(false);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  height: 70,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
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
                      'False',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: scoreKeeper,
          ),
        ],
      ),
    );
  }
}
