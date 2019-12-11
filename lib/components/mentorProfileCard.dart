import 'package:card_selector/card_selector.dart';
import 'package:flutter/material.dart';

const list = ["Amanda", "Miriam", "Loic", "Senior", "Tabi"];
const lang = ["Dart", "Python", 'Javascript', "Kotlin", "Java"];
const img = [
  'assets/images/amanda.jpeg',
  'assets/images/miriam.jpeg',
  'assets/images/Loic.jpg',
  'assets/images/senior.jpeg',
  'assets/images/Loic.jpg',
];

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
              backgroundImage: AssetImage(img[i]),
            ),
            Expanded(
//              height: 100,
//              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    list[i],
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(lang[i], style: Theme.of(context).textTheme.subtitle),
                ],
              ),
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
