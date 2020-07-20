import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'play_button.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  @override
  createState() {
    return _Home();
  }

  void dispose(){
    _Home().dispose();
  }
}

class _Home extends State<Home> {
  AudioPlayer advancedPlayer;

  void initState(){
    super.initState();
    advancedPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

    print("initState called");
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
    loadMusic();
    //Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock Paper Scissor game'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      {
                        dispose();
                        Navigator.pushNamed(context, '/play');
                      }
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
                      dispose();
                      {
                        Navigator.pushNamed(context, '/play');
                      }
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
                    )),
                GestureDetector(
                    onTap: () {
                      dispose();
                      {
                        Navigator.pushNamed(context, '/play');
                      }
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
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(20),
                    child: PlayButton()
                ),
              ],
            )
          ],
        ),
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
      ),
    );
  }
}
