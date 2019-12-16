import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peer_learning/dashboard.dart';
import 'package:peer_learning/Login/signup.dart';
import 'package:peer_learning/services/authentication.dart';

class SigninPage extends StatefulWidget {
  static String tag = 'login';
  final BaseAuth auth;
  final VoidCallback loginCallback;

  SigninPage({
    this.auth,
    this.loginCallback
});

  @override
  State<StatefulWidget> createState() {
    return _SigninPageState();
  }
}

class _SigninPageState extends State<SigninPage>
    with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
   String _password;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  String _errorMessage;
  bool _isLoading;



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

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // Check if form is valid before perform login or signup
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
          userId = await widget.auth.signIn(_email, _password);

          print('Signed in: $userId');

        setState(() {
          _isLoading = false;
        });

          if (userId.length > 0 && userId != null ) {
            widget.loginCallback();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard()));
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
        body: Center(
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
//                    Center(
//                      child: Container(
//                        margin: EdgeInsets.only(left: 16, top: 8),
//                        child: Text(
//                          'Welcome Back',
//                          style: TextStyle(
//                              fontSize: 22, fontWeight: FontWeight.bold),
//                        ),
//                      ),
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(left: 16, top: 8),
//                      child: Text(
//                        "Let's get started by signing in",
//                        style: TextStyle(
//                            fontSize: 18, fontWeight: FontWeight.normal),
//                      ),
//                    ),

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
                          maxLines: 1,
                          autofocus: false,
//                        validator: Validator.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: Icon(
                              Icons.mail,
                              color: Colors.blueAccent,
                            )
                          ),
                          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
                          onSaved: (value) => _email = value.trim()
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            left: 22, right: 22, top: 8, bottom: 8),
                        child: TextFormField(
                          autofocus: false,
//                        validator: Validator.validatePassword,
                          obscureText: true,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Password',
                              hintText: 'Password',
                              icon: new Icon(
                                Icons.lock,
                                color: Colors.grey,
                              )
                          ),
                          validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
                          onSaved: (value) => _password = value.trim() ,
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
                            onPressed: () {
                              validateAndSubmit();
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
                                  builder: (context) => SignUpPage(
                                      auth: widget.auth,
                                  loginCallback: widget.loginCallback)));

                        },
                        child: Text("sign up"),
                      )
                    ],
                  ),
                ],
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
