import 'package:flutter/material.dart';
import 'Quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
Quizbrain quizbrain = new Quizbrain();

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

  List<Icon> status = [];

  void empty_status(){
    status.clear();
  }

  void checkans(bool userans){
    bool correctans = quizbrain.getanswer();

    if(quizbrain.overflow == true){
      Alert(
        context: context,
        type: AlertType.success,
        title: "Completed",
        desc: "You have reached the end of the quiz!",
        buttons: [
          DialogButton(
            child: Text(
              "Reattempt",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();

      empty_status();
      setState((){
        quizbrain.overflow = false;
        quizbrain.reset();
      });
    }

    else {
      if (correctans == userans && quizbrain.overflow == false) {
        status.add(Icon(Icons.check, color: Colors.green));
      } else if (quizbrain.overflow == false) {
        status.add(Icon(Icons.close, color: Colors.red));
      }
      setState(() {
        quizbrain.nextQuestion();
      });
    }
  }

  @override
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
               quizbrain.getquestion(),
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
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
               checkans(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkans(false);
              },
            ),
          ),
        ),

        Row(
          children: status,
        )
      ],
    );
  }
}
