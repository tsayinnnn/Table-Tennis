import 'package:flutter/material.dart';
import 'package:ttsb/winner.dart';

class scoreboard extends StatefulWidget {
  final String p1Name;
  final String p2Name;
  bool p1serve;
  final bool threegame;

  scoreboard({
    Key? key,
    required this.p1Name,
    required this.p2Name,
    required this.p1serve,
    required this.threegame,
  }) : super(key: key);

  @override
  State<scoreboard> createState() => _scoreboardState();
}

class Responsive {
  static double width(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  static double height(double percentage, BuildContext context) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }
}

class _scoreboardState extends State<scoreboard> {
  int player1Score = 0;
  int player2Score = 0;
  int player1Set = 0;
  int player2Set = 0;

  void addPlayer1Score() {
    setState(() {
      player1Score++;
      if ((player1Score + player2Score) % 2 == 0) {
        widget.p1serve = !widget.p1serve;
      }
      if (player1Score >= 11 && player1Score - player2Score >= 2) {
        player1Set++;
        resetScore();
      }
    });
  }

  void addPlayer2Score() {
    setState(() {
      player2Score++;
      if ((player1Score + player2Score) % 2 == 0) {
        widget.p1serve = !widget.p1serve;
      }
      if (player2Score >= 11 && player2Score - player1Score >= 2) {
        player2Set++;
        resetScore();
      }
    });
  }

  void reducePlayer1Score() {
    setState(() {
      if (player1Score > 0) {
        player1Score--;
        if ((player1Score + player2Score) % 2 != 0) {
          widget.p1serve = !widget.p1serve;
        }
      }
    });
  }

  void reducePlayer2Score() {
    setState(() {
      if (player2Score > 0) {
        player2Score--;
        if ((player1Score + player2Score) % 2 != 0) {
          widget.p1serve = !widget.p1serve;
        }
      }
    });
  }

  void resetScore() {
    player1Score = 0;
    player2Score = 0;
    gameSet();
  }

  void gameSet() {
    if (widget.threegame) {
      if (player1Set == 2) {
        setState(() {
          Winner(winner: widget.p1Name);
        });
      } else if (player2Set == 2) {
        setState(() {
          Winner(winner: widget.p2Name);
        });
      }
    } else {
      if (player1Set == 5) {
        setState(() {
          Winner(winner: widget.p1Name);
        });
      } else if (player2Set == 5) {
        setState(() {
          Winner(winner: widget.p2Name);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
            // names
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('${widget.p1Name}'), Text('${widget.p2Name}')],
            ),
            //box
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.p1serve ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 211, 174),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          '$player1Set',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 2, right: 8),
                  child: Container(
                    width: Responsive.width(30, context),
                    height: Responsive.height(30, context),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 188, 207, 211),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '$player1Score',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 8, bottom: 8, right: 2),
                  child: Container(
                    width: Responsive.width(30, context),
                    height: Responsive.height(30, context),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 188, 207, 211),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '$player2Score',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.p1serve ? Colors.grey : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 211, 174),
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          '$player2Set',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: addPlayer1Score, child: Text("+")),
                ElevatedButton(onPressed: addPlayer2Score, child: Text("+")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: reducePlayer1Score, child: Text("-")),
                ElevatedButton(onPressed: reducePlayer2Score, child: Text("-")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
