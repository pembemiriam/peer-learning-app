import 'package:flutter/material.dart';
import 'dart:ui';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileState();
  }
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: MyHomePage(title: 'Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        new Container(
          color: Colors.blue,
        ),
        new BackdropFilter(
            filter: new ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: new Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.9),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            )),
        new Scaffold(
            appBar: new AppBar(
              title: new Text(widget.title),
              centerTitle: false,
              elevation: 0.0,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: new Center(
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      new SizedBox(
                        height: _width < _height ? _width / 20 : _height / 20,
                      ),
                      new CircleAvatar(
                        radius: _width < _height ? _width / 4 : _height / 4,
                        backgroundImage: AssetImage("assets/images/Loic.jpg"),
                      ),
                      new SizedBox(
                        height: _width < _height ? _width / 20 : _height / 20,
                      ),
                      new Text(
                        'Fonkam Loic',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: _width / 15,
                            color: Colors.white),
                      ),
                      new Padding(
                        padding: new EdgeInsets.only(
                            top: _height / 30,
                            left: _width / 8,
                            right: _width / 8),
                        child: Text(
                          'C programmer, Javascript, Dart, CyberScurity Engineer. I am an Ethical Hacker :)',
                          style: new TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: _width / 25,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Divider(
                        height: _width < _height ? _width / 30 : _height / 30,
                        color: Colors.white,
                      ),
                      new Row(
                        children: <Widget>[
                          rowCell(33, 'POSTS'),
                          rowCell(66, 'FOLLOWERS'),
                          rowCell(25, 'FOLLOWING'),
                        ],
                      ),
                      new Divider(
                          height: _width < _height ? _width / 20 : _height / 20,
                          color: Colors.white),
                      new Padding(
                        padding: new EdgeInsets.only(
                            left: _width / 8, right: _width / 8),
                        child: new FlatButton(
                          onPressed: () {},
                          child: new Container(
                              child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Icon(Icons.person),
                              new SizedBox(
                                width: _width < _height
                                    ? _height / 20
                                    : _width / 20,
                              ),
                              new Text('FOLLOW')
                            ],
                          )),
                          color: Colors.blue[50],
                        ),
                      ),
                    ],
                  ),
                ],

              ),
            ))
      ],
    );
  }

  Widget rowCell(int count, String type) => new Expanded(
          child: new Column(
        children: <Widget>[
          new Text(
            '$count',
            style: new TextStyle(color: Colors.white),
          ),
          new Text(type,
              style: new TextStyle(
                  color: Colors.white, fontWeight: FontWeight.normal))
        ],
      ));
}
