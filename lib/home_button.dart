import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'home.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: Duration(milliseconds: 000),
      glowColor: Colors.white,
      endRadius: 60.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 00),
      child: MaterialButton(
        onPressed: () {
          {
            Route route = MaterialPageRoute(builder: (context) => Home());
            Navigator.pushReplacement(context, route);
          }
        },
        elevation: 10.0,
        shape: CircleBorder(),
        child: Container(
          width: 60.0,
          height: 60.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
          child: Text(
            "Play",
            style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
