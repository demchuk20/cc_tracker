import 'package:flutter/material.dart';
import 'package:test_project/CCList.dart';

void main() {
  runApp(CCTracker());
}

class CCTracker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber
      ),
      home: CCList()
    );
  }
}

