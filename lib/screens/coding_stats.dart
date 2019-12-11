import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:peer_learning/components/statsGraph.dart';

class CodingStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CodingStatsState();
  }
}

class CodingStatsState extends State<CodingStats> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Coding Statistics',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                      height: 400,
                      width: double.infinity,
                      child: DonutAutoLabelChart.withSampleData()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
