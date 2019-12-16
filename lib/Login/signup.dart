import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peer_learning/services/authentication.dart';

import '../dashboard.dart';

class SignUpPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback loginCallback;

  SignUpPage({
    this.auth,
    this.loginCallback
});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
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

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {

          userId = await widget.auth.signUp(_email, _password, _name);
          Navigator.of(context).pushReplacementNamed('/home');

          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');



        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();

        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }


  dynamic myController = TextEditingController();
  bool isSwitched = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;
  String _errorMessage;
  bool _isLoading;


  bool _autoValidate = false;
  bool _loadingVisible = false;
  String _currentValue = "Mentor or Mentee";

  String _currentProg = "Programming Language";

//  getEmail(value) {
//    setState(() {
//      _email = value;
//
//      myController.clear();
//    });
//  }

//  getPassword(value) {
//    setState(() {
//      _password = value;
//      myController.clear();
//    });
//  }

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
        child: SafeArea(
      child: Form(
    key: _formKey,
    autovalidate: _autoValidate,
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
//                        validator: Validator.validateEmail,
                      keyboardType: TextInputType.text,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Username',
                          icon: new Icon(
                            Icons.person,
                            color: Colors.grey,
                          )),
                      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                      onSaved: (value) => _email = value.trim(),                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22, right: 22, top: 16, bottom: 8),
                    child: TextFormField(
                      autofocus: false,
//                        validator: Validator.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        labelText: 'Email',
                          icon: new Icon(
                            Icons.mail,
                            color: Colors.grey,
                          )),
                      validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
                      onSaved: (value) => _email = value.trim(),
                    ),
                  ), //textArea for email
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22, right: 22, top: 16, bottom: 8),
                    child: TextFormField(
                      autofocus: false,
//                        validator: Validator.validatePassword,
                      obscureText: true,
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                          icon: new Icon(
                            Icons.lock,
                            color: Colors.grey,
                          )
                      ),
                      validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _password = value.trim(),
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
                    onPressed: () {
                     validateAndSubmit();
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
}
