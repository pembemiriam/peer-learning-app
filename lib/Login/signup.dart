import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../dashboard.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;

  dynamic newUser;

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;
  String _currentValue = "Mentor or Mentee";

  String _currentProg = "Programming Language";

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
      body: ModalProgressHUD(
        inAsyncCall: _loadingVisible,
        child: Container(
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Hero(
                          tag: 'logo',
                          child: Image.asset('assets/images/logo.png')),
                      height: _width < _height
                          ? (_width / 4) * controller.value
                          : (_height / 4) * controller.value,
                      width: 100 * controller.value,
                    ),
                    SizedBox(
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 22, right: 22, top: 16, bottom: 8),
                      child: TextFormField(
                        autofocus: false,
                        controller: _userName,
//                        validator: Validator.validateEmail,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 22, right: 22, top: 16, bottom: 8),
                      child: TextFormField(
                        autofocus: false,
                        controller: _email,
//                        validator: Validator.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                    ), //textArea for email
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 22, right: 22, top: 16, bottom: 8),
                      child: TextFormField(
                        autofocus: false,
                        controller: _password,
//                        validator: Validator.validatePassword,
                        obscureText: true,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Password',
                        ),
//                      onChanged: getPassword(myController.text),
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
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        _changeLoadingVisible();
                        try {
                          newUser = await _auth.createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text);
                        } catch (e) {
                          print(e);
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Sign up failed!"),
                                  content: Text(
                                      "Username already taken or You already got an account."),
                                );
                              });
                        }
                        _changeLoadingVisible();
                        if (newUser != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Dashboard(username: _userName.text),
                            ),
                          );
                        }
                      }, // upon login we navigate to the dashboard
                      child: Text("Sign Up"),
                    ),
                    SizedBox(
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
