import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'home.dart';

class PlayButton extends StatelessWidget {
  Home _home;
  PlayButton(this._home){}
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: Duration(milliseconds: 000),
      glowColor: Colors.white,
      endRadius: 80.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 00),
      child: MaterialButton(
        onPressed: () {
          { Navigator.pushNamed(context, '/play'); }
        },
        elevation: 10.0,
        shape: CircleBorder(),
        child: Container(
          width: 100.0,
          height: 100.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(80.0)),
          child: Text(
            'Play',
            style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}