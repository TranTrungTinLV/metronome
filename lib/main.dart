import 'package:flutter/material.dart';
import 'page.dart';

void main() {
  runApp(BMI());
}

class BMI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Color(0x2F2F2F00),
        ),
      ),
      home: HomePage(),
    );
  }
}
