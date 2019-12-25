import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peer_learning/dashboard.dart';
import 'package:peer_learning/Login/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class SigninPage extends StatefulWidget {
  static String tag = 'login';

  @override
  State<StatefulWidget> createState() {
    return _SigninPageState();
  }
}

class _SigninPageState extends State<SigninPage>
    with SingleTickerProviderStateMixin {
  String _status;

  dynamic user;

  AnimationController controller;
  Animation animation;

  void _signInAnon() async {
    FirebaseUser user = (await _auth.signInAnonymously()).user;
    if (user != null && user.isAnonymous == true) {
      setState(() {
        _status = "Signed in Anonymously";
      });
    } else {
      setState(() {
        _status = "Sign in failed";
      });
    }
  }

  void _signOut() async {
    await _auth.signOut();
    setState(() {
      _status = "Signed Out";
    });
  }

  @override
  void initState() {
    super.initState();

    _status = "Not Authenticated";

    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Text(
            'Sign In',
            style: TextStyle(fontSize: 30.0),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _loadingVisible,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          child: Hero(
                              tag: 'logo',
                              child: Image.asset('assets/images/logo.png')),
                          height: _width < _height
                              ? (_width / 4) * controller.value
                              : (_height / 4) * controller.value,
//                        height: 150 * controller.value,
                          width: 150 * controller.value,
                        ),
                        SizedBox(
                          height: _width < _height ? _width / 20 : _height / 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 22, right: 22, top: 8, bottom: 8),
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
                          ),
                        ),
                        SizedBox(
                          height: _width < _height ? _width / 20 : _height / 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 22, right: 22, top: 16, bottom: 8),
                          child: Container(
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(30.0),
                                  ),
                              onPressed: () async {
                                _changeLoadingVisible();
                                try {
                                  user = await _auth.signInWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text);
                                } catch (e) {
                                  print(e);
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Sign in failed!"),
                                          content: Text(
                                              "Your email/username is incorrect. Please check again and retry."),
                                        );
                                      });
                                }
                                _changeLoadingVisible();
                                if (user != null) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(),
                                    ),
                                  );
                                }

                                /* Anonymous signIn
                                try {
                                  _signInAnon();

                                  if (_status == "Signed in Anonymously") {}
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()));
                                } catch (e) {
                                  print(e);
                                }

                                 */
                              },
                              color: Colors.blue,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Raleway',
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text("Create an account:"),
                        FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: Text("sign up"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
}
