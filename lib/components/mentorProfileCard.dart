import 'package:card_selector/card_selector.dart';
import 'package:flutter/material.dart';

const list = ["Miriam", "Loic", "3", "4", "5"];

const colors = [
  Colors.blue,
  Colors.grey,
  Colors.red,
  Colors.cyan,
  Colors.amber
];

class MentorProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    List<Widget> widgets = [];
    for (int i = 0; i < 5; i++) {
      widgets.add(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colors[i],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              radius: _width < _height ? _width / 5 : _height / 5,
              backgroundImage: AssetImage('assets/images/Loic.jpg'),
            ),
            Text(
              list[i],
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      ));
    }
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: CardSelector(
        cards: widgets,
        mainCardWidth: 300,
        mainCardHeight: 220,
        mainCardPadding: -32,
        cardAnimationDurationMs: 200,
        cardsGap: 24.0,
        dropTargetWidth: 8.0,
      ),
    );
  }
}
