import 'dart:math';
import 'package:flutter/material.dart';
import 'home_button.dart';

class Result extends StatelessWidget {
  final int _cpuWins, _playerWins;
  String _imgURL, _result;
  final bool _playerWon;
  // Random image if the player loses
  List <String> almost = [
    'https://media.giphy.com/media/12XDYvMJNcmLgQ/giphy.gif',
    'https://media.giphy.com/media/pJu3xzRa2PzTq/giphy.gif',
    'https://media.giphy.com/media/3oriOdiL4BFEWnW8ZW/giphy.gif'];

  // Random image if the player wins
  List <String> awesome = [
    'https://media.giphy.com/media/MAzunB1Ru6zAYlYgPD/giphy.gif',
    'https://media.giphy.com/media/dZWUtQ5y5AhXh7z9uO/giphy.gif',
    'https://media.giphy.com/media/5bvMcdx0gZf2mdiPjf/giphy.gif'
  ];

  Result(this._cpuWins, this._playerWins, this._playerWon) {
    int diff, awesomeIndex, almostIndex;
    Random rnd;
    const int min = 0;
    const int max = 2000;
    rnd = Random();
    final int almostLen = almost.length;
    final int awesomeLen = awesome.length;
    almostIndex = ((min + rnd.nextInt(max - min)) % almostLen);
    awesomeIndex = ((min + rnd.nextInt(max - min)) % awesomeLen);
    if (_playerWon) {
      diff = _playerWins - _cpuWins;
      _imgURL = awesome[awesomeIndex];
      _result = "You won the game by $diff!!";
    } else {
      diff = _cpuWins - _playerWins;
      _imgURL = almost[almostIndex];
      _result = "You lost by just $diff!!!!";
    }
  }

  @override
  Widget build(BuildContext context) {
    //Route route = MaterialPageRoute(builder: (context) => mainApp());
    //Navigator.pushReplacement(context, route);
    return Scaffold(
        appBar: AppBar(
        title: Text(_result,
            style: Theme.of(context).textTheme.headline6),
      ),
        //backgroundColor: Theme.of(context).backgroundColor,
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Text(_result, style: Theme.of(context).textTheme.bodyText1),
                Image.network(_imgURL, height: 199, width: 199,)
              ]),

              new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  HomeButton(),
              ])
            ])
    );
  }
}
