import 'dart:io';
import 'package:splashscreen/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:peer_learning/Login/signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

//  @override
//  void dispose() {
//    super.dispose();
//    controller.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "logo",
      child: SplashScreen(
        seconds: 2,
        navigateAfterSeconds: SigninPage(),
        title: Text(
          'Welcome to Peer Learning',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25.0 * controller.value),
        ),
        image: Image.asset(
          'assets/images/logo.png',
        ),
        gradientBackground: new LinearGradient(
            colors: [Colors.cyan, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 70.0 * controller.value,
        onClick: () => {},
        loaderColor: Colors.grey,
      ),
    );
  }
}

//
//class LoadingScreen extends StatefulWidget {
//  @override
//  _LoadingScreenState createState() => _LoadingScreenState();
//}
//
//class _LoadingScreenState extends State<LoadingScreen>
//    with SingleTickerProviderStateMixin {
//  AnimationController controller;
//  Animation animation;
//
//  @override
//  void initState() {
//    super.initState();
//
//    controller =
//        AnimationController(duration: Duration(seconds: 1), vsync: this);
//    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
//        .animate(controller);
//    controller.forward();
//
//    controller.addListener(() {
//      setState(() {});
//      print(animation.value);
//    });
//  }
//
////  @override
////  void dispose() {
////    super.dispose();
////    controller.dispose();
////  }
//
////  goToLogin() {
////    setState(() {
////      Navigator.push(
////          context, MaterialPageRoute(builder: (context) => SigninPage()));
////    });
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
//          sleep(Duration(seconds: 10));
//          Navigator.pushReplacement(
//              context, MaterialPageRoute(builder: (context) => SigninPage()));
//        }));
//
//    return Scaffold(
//      backgroundColor: animation.value,
//      body: Padding(
//        padding: EdgeInsets.symmetric(horizontal: 24.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Row(
//              children: <Widget>[
////                Hero(
////                  tag: "logo",
////                  child: Container(
////                    child: Image.asset('images/logo.png'),
////                    height: 60.0 * controller.value,
////                  ),
////                ),
//                TypewriterAnimatedTextKit(
//                  text: ['Peer Learning'],
//                  textStyle: TextStyle(
//                    fontSize: 45.0 * controller.value,
//                    fontWeight: FontWeight.w900,
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
