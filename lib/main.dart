import 'package:flutter/material.dart';
import 'package:peer_learning/screens/LoadingScreen.dart';
import './Login/signup.dart';
import './Login/signin.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner:false,
        home: LoadingScreen(),

    );
  }
}
