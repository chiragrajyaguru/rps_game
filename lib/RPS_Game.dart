import 'dart:async';
import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:rps_game/star_display.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'result.dart';

/*
RPS Game is the main class where we run the game. Allows anyone to pick an
option and then determines how this compares against our CPU selection
 */
class RPSGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RPSGame();
  }
}

class _RPSGame extends State<RPSGame> {
  //cpuSel - CPU pick
  //_playerSel
  int _cpuSel, _playerSel, _cpuCount, _playerCount;
  bool _gameOver = false;
  final navigatorKey = GlobalKey<NavigatorState>();
  AudioPlayer advancedPlayer;

  Timer _timer;
  int _start = 10;
  String _result_msg = "Pick -- Rock, Paper or Scissor";
  String _result_msg2 = "Make a selection below to begin...";
  static final _options = {"0": "Rock", "1": "Paper", "2": "Scissor"};
  _RPSGame() {
    _cpuCount = 0;
    _playerCount = 0;
    advancedPlayer = new AudioPlayer();
    loadMusic();

  }

  Future loadMusic() async {
    //AudioPlayer.logEnabled = true;
    advancedPlayer = await AudioCache().loop("mp3/home.mp3");
  }

  @override
  void dispose() {
    advancedPlayer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme:
    ThemeData.dark().copyWith(
      // Define the default brightness and colors.
      primaryColor: Colors.orange[400],
      accentColor: Colors.orange[200],
      accentColorBrightness: Brightness.dark,

      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      ),
    ); //Theme

    return Scaffold(
      appBar: AppBar(
        title: Text(_result_msg, style: Theme.of(context).textTheme.headline6),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                //color: Theme.of(context).backgroundColor,
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          _result_msg2,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ])),
            Container(
              margin: EdgeInsets.all(0),
              color: Theme.of(context).backgroundColor,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  _playerSel = 0;
                                  _cpuSel = setCPUSel();
                                  _result_msg = rockComp();
                                },
                              );
                            },
                            child: AvatarGlow(
                              endRadius: 60.0,
                              child: Material(
                                elevation: 8.0,
                                shape: CircleBorder(),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[100],
                                  child: Image.asset(
                                    'assets/images/Rock.png',
                                    height: 100,
                                  ),
                                  radius: 60.0,
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _playerSel = 1;
                              _cpuSel = setCPUSel();
                              _result_msg = paperComp();
                            });
                          },
                          child: AvatarGlow(
                            endRadius: 60.0,
                            child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: Image.asset(
                                  'assets/images/Paper.png',
                                  height: 100,
                                ),
                                radius: 60.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                _playerSel = 2;
                                _cpuSel = setCPUSel();
                                _result_msg = scissorComp();
                              },
                            );
                          },
                          child: AvatarGlow(
                            endRadius: 60.0,
                            child: Material(
                              elevation: 8.0,
                              shape: CircleBorder(),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: Image.asset(
                                  'assets/images/Scissor.png',
                                  height: 100,
                                ),
                                radius: 60.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          StarDisplay(value: _playerCount),
                          Text(''),
                          StarDisplay(value: _cpuCount)
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Player count of wins",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            Text(''),
                            Text(
                              "CPU count of wins",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  int setCPUSel() {
    Random rnd;
    int min = 0;
    int max = 2000;
    rnd = new Random();
    return ((min + rnd.nextInt(max - min)) % 3);
  }

  String rockComp() {
    String msg;
    _result_msg2 = choiceToMsg();
    switch (_cpuSel) {
      case 0:
        msg = "We drawed !!!";
        //return Result("Draw");
        break;
      case 1:
        msg = "You Lost !!!";
        _cpuCount++;
        //return Result("Lost");
        break;
      case 2:
        msg = "You Won !!!";
        _playerCount++;
        //return Result("Won");
        break;
    }
    checkResult();
    setState(() {});
    return msg;
  }

  String paperComp() {
    String msg;
    _result_msg2 = choiceToMsg();
    switch (_cpuSel) {
      case 0:
        msg = "You Won !!!";
        _playerCount++;
        //return Result("Draw");
        break;
      case 1:
        msg = "We drawed !!!";
        //return Result("Lost");
        break;
      case 2:
        msg = "You Lost !!!";
        _cpuCount++;
        //return Result("Won");
        break;
    }
    checkResult();
    setState(() {});
    return msg;
  }

  String scissorComp() {
    String msg;
    _result_msg2 = choiceToMsg();
    switch (_cpuSel) {
      case 0:
        msg = "You Lost !!!";
        _cpuCount++;
        //return Result("Draw");
        break;
      case 1:
        msg = "You Won !!!";
        _playerCount++;
        //return Result("Lost");
        break;
      case 2:
        msg = "We Drawed !!!";
        //return Result("Won");
        break;
    }
    checkResult();
    setState(() {});
    return msg;
  }

  /*
  After every decision, check If the game is done.. let's show the final results
   */
  void checkResult() {
    if (_cpuCount == 5) {
      _gameOver = true;
      dispose();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Result(_cpuCount, _playerCount, false),
          ));
      //new MaterialPageRoute builder: (context) => Result(_cpuCount, _playerCount, false));
    } else if (_playerCount == 5) {
      _gameOver = true;
      dispose();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Result(_cpuCount, _playerCount, true),
          ));
    } else
      return;
  }

  /*
  Convert integer selection to human choice
   */
  String choiceToMsg() {
    String cpuChoice, playerChoice;
    for (var entry in _options.entries) {
      if (entry.key == _cpuSel.toString()) cpuChoice = entry.value;
      if (entry.key == _playerSel.toString()) playerChoice = entry.value;
    }
    return ("You chose $playerChoice and I chose $cpuChoice");
  }
}
