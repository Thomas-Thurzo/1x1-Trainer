import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:ein_mal_eins_app/konstanten.dart';
import 'package:flutter/material.dart';
import 'package:simple_numpad/simple_numpad.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _ausgabe = '';
  int _highScore = 0;
  int _zahl1 = Random().nextInt(9) + 1;
  int _zahl2 = Random().nextInt(9) + 1;

  final ConfettiController confettiController = ConfettiController(
    duration: Duration(seconds: 1),
  );

  void ziffernBtnPressed(String str) {
    switch (str) {
      case 'BACKSPACE':
        // This case is accessible when you have set "useBackspace: true".
        //removeLast();
        break;
      case 'del':
        _ausgabe = '';
      default:
        if (_ausgabe.length < 2) {
          _ausgabe = _ausgabe + str;
        }
        break;
    }
  }

  void antwortGebenBtnPressed() {
    int ergebnis = _zahl1 * _zahl2;
    if (int.parse(_ausgabe) == ergebnis) {
      _highScore++;
      zufallsZahlenErzeugen();
      _ausgabe = '';
      confettiController.play();
    } else {
      _ausgabe = 'Falsch';
      _highScore = 0;
    }
  }

  void zufallsZahlenErzeugen() {
    _zahl1 = Random().nextInt(9) + 1;
    _zahl2 = Random().nextInt(9) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '1 x 1 Trainer',
              style: TextStyle(
                color: farbe4,
                fontSize: kFontSize30,
                fontWeight: FontWeight.w800,
              ),
            ),
            backgroundColor: farbe3,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Highscore Bereich
                Container(
                  padding: EdgeInsets.all(kPadding10),
                  alignment: Alignment.center,
                  color: farbe2,
                  child: Text(
                    'Highscore: $_highScore',
                    style: TextStyle(fontSize: kFontSize30),
                  ),
                ),

                // Frage Bereich
                Container(
                  color: farbe1,
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_zahl1.toString(), style: TextStyle(fontSize: 60)),
                      Text('X', style: TextStyle(fontSize: 50)),
                      Text(_zahl2.toString(), style: TextStyle(fontSize: 60)),
                    ],
                  ),
                ),

                // Ziffern Ausgabe
                Container(
                  alignment: Alignment.center,
                  color: farbe2,
                  child: Text(_ausgabe, style: TextStyle(fontSize: 60)),
                ),

                // Ziffern Einfabe
                Container(
                  padding: EdgeInsets.all(kPadding10),
                  child: SimpleNumpad(
                    buttonWidth: 60,
                    buttonHeight: 60,
                    gridSpacing: 10,
                    buttonBorderRadius: 8,
                    backgroundColor: farbe3,
                    textStyle: const TextStyle(
                      color: farbe1,
                      fontSize: kFontSize30,
                      fontWeight: FontWeight.w800,
                    ),
                    useBackspace: true,
                    optionText: 'del',
                    onPressed: (str) {
                      setState(() {
                        ziffernBtnPressed(str);
                      });
                    },
                  ),
                ),

                // Antwort abgeben Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: farbe3,
                    foregroundColor: farbe1,
                    textStyle: TextStyle(
                      fontSize: kFontSize30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      antwortGebenBtnPressed();
                    });
                  },
                  child: Text('Antwort abgeben'),
                ),
              ],
            ),
          ),
        ),

        // Confetti Widget
        ConfettiWidget(
          confettiController: confettiController,
          numberOfParticles: 50,
        ),
      ],
    );
  }
}
