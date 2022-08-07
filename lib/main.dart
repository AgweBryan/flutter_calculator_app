import 'package:flutter/material.dart';
import 'package:flutter_calculator_app/calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator app',
      home: Calculator(),
    );
  }
}
