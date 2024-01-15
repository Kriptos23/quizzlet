import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  List<Icon> icons = [];

  QuizBrain quizBrain = QuizBrain();

  bool lastOne = false;

  int cor = 0;
  int inc = 0;

  @override
  Widget build(BuildContext context) {


    //TODO: here is functions

    void checkAnswer(bool userAnswer)
    {

      print('lastOne = $lastOne');

      if(quizBrain.isFinished(quizBrain.getQNum(), lastOne)){
        Alert(context: context, title: "You finished the quiz!", desc: "You "
            "got $cor right and $inc incorrect")
            .show();
        quizBrain.reset();
        icons.clear();
        cor = 0;
        inc = 0;

      }else{
        if(userAnswer == quizBrain.getAnswer() && quizBrain.getQNum()
            < 12)
        {
          icons.add(Icon(Icons.check, color: Colors.green));
          cor++;
          print("got $cor right and $inc incorrect");
        }
        else if(userAnswer != quizBrain.getAnswer() && quizBrain.getQNum()
            < 12){
          icons.add(Icon(Icons.close, color: Colors.red));
          inc++;
          print("got $cor right and $inc incorrect");
        }
        else if(quizBrain.getQNum() == 12 && lastOne == false){
          if(userAnswer == quizBrain.getAnswer())
          {
            icons.add(Icon(Icons.check, color: Colors.green));
            lastOne = true;
            print('lastOne = $lastOne');
            cor++;
            print("got $cor right and $inc incorrect");
          }
          else if(userAnswer != quizBrain.getAnswer()){
            icons.add(Icon(Icons.close, color: Colors.red));
            lastOne = true;
            print('lastOne = $lastOne');
            inc++;
            print("got $cor right and $inc incorrect");
          }
        }
      }

    }

    Expanded buttonsTF(bool buttonTF)
    {
      return
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: (buttonTF == true) ? Colors.green : Colors.red,
              ),
              child: Text(
                (buttonTF == true) ? 'true' : 'false',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState(() {
                  checkAnswer(buttonTF);
                  quizBrain.nextQuestion();
                  quizBrain.isFinished(quizBrain.getQNum(), lastOne);
                });
              },
            ),
          ),
        );
    }

    //TODO: here is main code

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
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        buttonsTF(true),
        buttonsTF(false),
        Row(
          children: icons,
        )
      ],
    );


  }
}



/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
