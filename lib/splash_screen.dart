import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:quizzler/QuizPage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final player = AudioCache();

  @override
  void initState() {
    super.initState();
    _mockCheckForSession().then((status) {
      _navigateToHome();
    });
  }

  Future<bool> _mockCheckForSession() async {
    player.play('intro_note.wav');
    //wait 4 seconds before going to home screen
    await Future.delayed(Duration(milliseconds: 4000), () {});
    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => QuizPage()));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff6067d0),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/question.png',
              width: 180.0,
              height: 180.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Quizzler',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    letterSpacing: 3.0,
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w600,
                    shadows: <Shadow>[
                      Shadow(
                          blurRadius: 18.0,
                          color: Colors.black38,
                          offset: Offset.fromDirection(120, 12))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
