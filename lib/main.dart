import 'package:flutter/material.dart';
import './Login/signup.dart';
import 'gender_stats.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Gender Stats"),

        ),

        body: Center(child: GenderStats()),
      ),
    );
  }
}
