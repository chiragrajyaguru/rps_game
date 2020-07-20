import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:rps_game/result.dart';
import 'RPS_Game.dart';
import 'result.dart';
import 'home.dart';

void main() {
  runApp( mainApp());

}

class mainApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
    return MaterialApp(
      title: 'RPS Game',
      theme: ThemeData.dark().copyWith(
        // Define the default brightness and colors.
        primaryColor: Colors.orange[400],
        accentColor: Colors.orange[200],
        accentColorBrightness: Brightness.dark,


        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ), //Theme

      initialRoute: '/',
      routes: {
       '/': (context) => Home(),
        '/play': (context) => RPSGame(),
        '/result': (context) => Result(0, 0, true),
       // '/second': (context) => SecondScreen(),
      },

    );

  }

}