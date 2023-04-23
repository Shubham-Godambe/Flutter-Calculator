// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'colors.dart';

void main() {
  runApp(MaterialApp(
    home: CalculatorApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CalculatorApp> {
  double firstNum = 0;
  double secondNum = 0;
  var input = "";
  var output = " ";
  var operation = "";

  OnButtonclick(value) {
    // if value is AC
    if (value == "AC") {
      input = "0";
      output = "";
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
      }
    } else {
      input = input + value;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Row(
          children: [
            Text("Calculator"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: operatorColor,
              ),
              child: Center(
                child: Text(
                  'Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  input,
                  style: TextStyle(
                      fontSize: 48, color: Colors.white.withOpacity(1)),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(output,
                    style: TextStyle(
                        fontSize: 28, color: Colors.white.withOpacity(0.7)))
              ],
            ),
          )),
          // button area

          Row(
            children: [
              button(text: "AC", tcolor: orangeColor, bColor: operatorColor),
              button(text: "<-", tcolor: orangeColor, bColor: operatorColor),
              button(text: "+/-", bColor: operatorColor),
              button(text: "/", bColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(text: "*", bColor: operatorColor),
            ],
          ),

          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "5"),
              button(text: "-", bColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(text: "+", bColor: operatorColor),
            ],
          ),
          Row(
            children: [
              button(text: "%", bColor: operatorColor),
              button(text: "0"),
              button(text: ".", bColor: operatorColor),
              button(text: "=", bColor: orangeColor),
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, bColor = buttonColor}) {
    return Expanded(
        child: Container(
      margin: EdgeInsets.all(8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.all(22),
            backgroundColor: bColor),
        onPressed: () {
          OnButtonclick(text);
        },
        child: Text(
          text,
          style: TextStyle(
              color: tcolor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    ));
  }
}
