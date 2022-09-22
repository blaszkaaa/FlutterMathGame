import 'dart:math';
import 'package:aplikacja1/util/result_message.dart';
import 'package:aplikacja1/constans.dart';
import 'package:aplikacja1/util/my_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

//odpowiedzi
String userAnswer = '';

//uzytkownik dotyka

class _HomePageState extends State<HomePage> {
  //lista numer pad
  List<String> numberPad = [
    '7',
    '8',
    '9',
    'C',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];
// liczba A i liczba B

  int numberA = 1;
  int numberB = 1;

  String userAnswer = '';

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        //obliczenia
        checkResult();
      } else if (button == 'C') {
        userAnswer = '';
      } else if (button == 'DEL') {
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        userAnswer += button;
      }
    });
  }

  //sprawdzanie odpowiedzi
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ReturnMessage(
              message: "Dobrze",
              onTap: goToNextQuestion,
              icon: Icons.arrow_forward,
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ReturnMessage(
              message: "Źle",
              onTap: goBackToQuestion,
              icon: Icons.rotate_left,
            );
          });
    }
  }

  var randomNumber = Random();

  void goToNextQuestion() {
    Navigator.of(context).pop();

    setState(() {
      userAnswer = '';
    });

    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  void goBackToQuestion() {
    Navigator.of(context).pop();
    setState(() {
      userAnswer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[300],
        body: Column(
          children: [
            // level
            Container(
              height: 160,
              color: Colors.deepPurple,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 55),
                  child: Text(
                    "Math Game",
                    style: whiteTextStyle,
                  ),
                ),
              ),
            ),
            //pytania
            Expanded(
              child: Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //pytania
                      Text(
                        numberA.toString() + '+' + numberB.toString() + '=',
                        style: whiteTextStyle,
                      ),
                      //odpowiedzi
                      Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple[400],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            userAnswer,
                            style: whiteTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //numer
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: GridView.builder(
                    itemCount: numberPad.length,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return Mybutton(
                        child: numberPad[index],
                        onTap: () => buttonTapped(numberPad[index]),
                      );
                    },
                  ),
                )),
          ],
        ));
  }
}
