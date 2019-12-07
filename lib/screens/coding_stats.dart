import 'package:flutter/material.dart';

class CodingStats extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CodingStatsState();
  }

}

class CodingStatsState extends State<CodingStats>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Coding Statistics',
          style: TextStyle(fontSize: 30),),
      ),
    );
  }
}