import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:peer_learning/services/authentication.dart';

class GenderStats extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  GenderStats({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  @override
  _GenderStatsState createState() => _GenderStatsState();
}

class _GenderStatsState extends State<GenderStats> {

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Gender Statistics',
            style: TextStyle(fontSize: 20),
          ),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut),
            FutureBuilder(
              future: FirebaseAuth.instance.currentUser(),
              builder: (BuildContext context, AsyncSnapshot user) {
                if (user.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Welcome ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user.data.displayName.toString() + "!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                        ),
                      )
                    ],
                  );
                }
              },
            ),          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/boy.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    SizedBox(
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                    Text(
                      '223 males',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    SizedBox(
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                    Image.asset(
                      'assets/girl.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                    SizedBox(
                      height: _width < _height ? _width / 20 : _height / 20,
                    ),
                    Text(
                      '223 females',
                      style: TextStyle(fontSize: 25.0),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
