import 'package:flutter/material.dart';

class FindMentor extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FindMentorState();
  }

}

class FindMentorState extends State<FindMentor>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find a mentor',
        style: TextStyle(fontSize: 30),),
      ),
    );
  }
}