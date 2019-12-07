import 'package:flutter/material.dart';

class Profile extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileState();
  }

}

class ProfileState extends State<Profile>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My profile',
          style: TextStyle(fontSize: 30),),
      ),
    );
  }
}