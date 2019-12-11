import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:peer_learning/components/mentorProfileCard.dart';

import '../dashboard.dart';

class FindMentor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FindMentorState();
  }
}

class FindMentorState extends State<FindMentor> {
  String _progLang = "Dart";
  String _mentor = "Miriam";
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // to avoid keyboard resizing widget on the screen
      appBar: SearchBar(
        defaultBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          title: Text(
            'Find a mentor',
            style: TextStyle(fontSize: 20),
          ),
        ),
        //TODO: Query callbacks; to get notified about user input specify onQueryChange and/or onQuerySubmitted callback.
//        onQueryChanged: (query) => _handleQueryChanged(context, query),
//        onQuerySubmitted: (query) => _handleQuerySubmitted(context, query),

        //TODO: QuerySetLoader; By passing QuerySetLoader as an argument one can additionally benefit from search results being automatically built as ListView widget whenever search query changes.
//        loader: QuerySetLoader<Item>(
//          querySetCall: _getItemListForQuery,
//          itemBuilder: _buildItemWidget,
//          loadOnEachChange: true,
//          animateChanges: true,
//        ),
        /*The following 2 commented lines will be used below*/
//          List<Item> _getItemListForQuery(String query) { ... }
//          Widget _buildItemWidget(Item item) { ... }
      ),
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 5.0, bottom: 10.0, right: 10, left: 20),
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MentorProfileCard(),
                  new SizedBox(
                    height: _width < _height ? _width / 20 : _height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "Choose a Programming Language",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      DropdownButton<String>(
                        hint: Text(_progLang),
                        items: <String>[
                          "C",
                          'C++',
                          "Dart",
                          "Python",
                          "JavaScript",
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _progLang = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _width < _height ? _width / 20 : _height / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Choose a Mentor: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      DropdownButton<String>(
                        hint: Text(_mentor),
                        items: <String>[
                          "Vanessa",
                          'Shalom',
                          "Senior",
                          "Amanda",
                          "Rudy",
                          "Noela",
                          "Loic",
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _mentor = value;
                          });
                        },
                      ),
                    ],
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                        );
                      });
                    }, // upon login we navigate to the dashboard
                    child: Text("Learn"),
                  ),
                  SizedBox(
                    height: _width < _height ? _width / 20 : _height / 20,
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}
