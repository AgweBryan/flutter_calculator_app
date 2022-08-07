import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                fontSize: equationFontSize,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                fontSize: resultFontSize,
              ),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            children: [
              Container(
                color: Colors.red,
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .5,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('C', 1, Colors.redAccent),
                        buildButton('<', 1, Colors.blue),
                        buildButton('/', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('7', 1, Colors.grey.shade900),
                        buildButton('8', 1, Colors.grey.shade900),
                        buildButton('9', 1, Colors.grey.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('4', 1, Colors.grey.shade900),
                        buildButton('5', 1, Colors.grey.shade900),
                        buildButton('6', 1, Colors.grey.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('1', 1, Colors.grey.shade900),
                        buildButton('2', 1, Colors.grey.shade900),
                        buildButton('3', 1, Colors.grey.shade900),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('.', 1, Colors.grey.shade900),
                        buildButton('0', 1, Colors.grey.shade900),
                        buildButton('00', 1, Colors.grey.shade900),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton('x', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('-', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('+', 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton('=', 2, Colors.red),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  buildButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: Colors.white,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        equation = '0';
        result = '0';
        equationFontSize = 38;
        resultFontSize = 48;
      } else if (buttonText == '<') {
        equationFontSize = 38;
        resultFontSize = 48;
        equation = equation.substring(0, equation.length - 1);
        if (equation.isEmpty) {
          equation = '0';
        }
      } else if (buttonText == '=') {
        equationFontSize = 38;
        resultFontSize = 48;
        expression = equation;
        expression = expression.replaceAll('x', '*');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = 'error';
        }
      } else {
        equationFontSize = 48;
        resultFontSize = 38;
        if (equation == '0') {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }
}
