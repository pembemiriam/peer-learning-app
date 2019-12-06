import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SigninPage extends StatefulWidget {
  static String tag = 'login';

  @override
  State<StatefulWidget> createState() {
    return _SigninPageState();
  }
}

class _SigninPageState extends State<SigninPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();

  bool _autoValidate = false;
  bool _loadingVisible = false;



  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;

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
                    Padding(
                      padding: EdgeInsets.only(left: 22, right: 22, top: 16, bottom: 8),
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
                      padding: EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
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

                    Padding(
                      padding: EdgeInsets.only(left: 22, right: 22, top: 16, bottom: 8),
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
//                          borderRadius: new BorderRadius.circular(30.0),
                          ),
                          onPressed: () {},
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
                    )
                  ],
                ),
              ],
            ),
          ),
          ),
        )
    );
  }

  Future<void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

}