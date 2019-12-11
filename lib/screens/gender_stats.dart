import 'package:flutter/material.dart';

class GenderStats extends StatefulWidget {
  @override
  _GenderStatsState createState() => _GenderStatsState();
}

class _GenderStatsState extends State<GenderStats> {
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
