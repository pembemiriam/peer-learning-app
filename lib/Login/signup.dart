import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
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
      print(animation.value);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  dynamic myController = TextEditingController();
  bool isSwitched = false;
  String _email = '';
  String _password = '';

  String _currentValue = "Mentor or Mentee";

  String _currentProg = "Programming Language";

  getEmail(value) {
    setState(() {
      _email = value;

      myController.clear();
    });
  }

  getPassword(value) {
    setState(() {
      _password = value;
      myController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Sign Up",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Hero(
                    tag: 'logo', child: Image.asset('assets/images/logo.png')),
                height: _width < _height
                    ? (_width / 4) * controller.value
                    : (_height / 4) * controller.value,
                width: 100 * controller.value,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 16, bottom: 8),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(hintText: 'Your name'),
                  onChanged: getEmail(myController.text),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 16, bottom: 8),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: getEmail(myController.text),
                ),
              ), //textArea for email
              Padding(
                padding: const EdgeInsets.only(
                    left: 22, right: 22, top: 16, bottom: 8),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  onChanged: getPassword(myController.text),
                ),
              ), //
              // textArea for password
              DropdownButton<String>(
                hint: Text(_currentValue),
                items: <String>[
                  "Mentor",
                  'Mentee',
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentValue = value;
                  });
                },
              ),
              DropdownButton<String>(
                hint: Text(_currentProg),
                items: <String>[
                  "C",
                  'C++',
                  "Dart",
                  'Kotlin',
                  "Python",
                  "JavaScript",
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _currentProg = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("male"),
                  Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    //activeColor: Colors.green,
                  ),
                  Text('female'),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  });
                }, // upon login we navigate to the dashboard
                child: Text("Sign Up"),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
