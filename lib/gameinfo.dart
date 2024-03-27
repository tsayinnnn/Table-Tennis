// fix requires, ilagay sa arguments (OOP) para magamit sa mismong scoreboard
// fix choice chips (boolean keme)

import 'package:flutter/material.dart';
import 'package:ttsb/scoreboard.dart';

class game extends StatefulWidget {
  game({super.key});

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  String player1 = '';

  String player2 = '';

  bool isplayer1serve = false;

  bool isThreeSet = false;

  void _setFirstPlayer(bool isFirstPlayer) {
    setState(() {
      isplayer1serve = isFirstPlayer;
    });
  }

  void _setGameMode(bool isBestofThree) {
    setState(() {
      isThreeSet = isBestofThree;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Player Selection",
              style: Theme.of(context).textTheme.headlineSmall),
          // input name player 1 and 2
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                TextField(
                    onChanged: (value) => player1 = value,
                    decoration: InputDecoration(labelText: "Player 1 Name")),
                TextField(
                    onChanged: (value) => player2 = value,
                    decoration: InputDecoration(labelText: "Player 2 Name"))
              ],
            ),
          ),
          Text("First Service:"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text('Player 1'),
                selected: isplayer1serve,
                onSelected: (selected) => _setFirstPlayer(selected),
              ),
              SizedBox(width: 16),
              ChoiceChip(
                label: Text('Player 2'),
                selected: !isplayer1serve,
                onSelected: (selected) => _setFirstPlayer(!selected),
              ),
            ],
          ),
          // number of set
          Text("Game Play: "),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text('Best of 3'),
                selected: isThreeSet,
                onSelected: (selected) => _setGameMode(selected),
              ),
              SizedBox(width: 16),
              ChoiceChip(
                label: Text('Best of 5'),
                selected: !isThreeSet,
                onSelected: (selected) => _setGameMode(!selected),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => scoreboard(
                              p1Name: player1,
                              p2Name: player2,
                              p1serve: isplayer1serve,
                              threegame: isThreeSet,
                            )));
              },
              child: Text("Start"))
        ],

        //start
      ),
    ));
  }
}
