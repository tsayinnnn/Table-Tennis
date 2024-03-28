// fix requires, ilagay sa arguments (OOP) para magamit sa mismong scoreboard
// fix choice chips (boolean keme)

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class game extends StatefulWidget {
  game({super.key});

  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  TextEditingController player1TextField = TextEditingController();
  TextEditingController player2TextField = TextEditingController();
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
      appBar: AppBar(),
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
                    controller: player1TextField,
                    decoration:
                        const InputDecoration(labelText: "Player 1 Name"),
                  ),
                  TextField(
                    controller: player2TextField,
                    decoration:
                        const InputDecoration(labelText: "Player 2 Name"),
                  )
                ],
              ),
            ),
            const Text("First Service:"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Player 1'),
                  selected: isplayer1serve,
                  onSelected: (selected) => _setFirstPlayer(selected),
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('Player 2'),
                  selected: !isplayer1serve,
                  onSelected: (selected) => _setFirstPlayer(!selected),
                ),
              ],
            ),
            // number of set
            const Text("Game Play: "),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('Best of 3'),
                  selected: isThreeSet,
                  onSelected: (selected) => _setGameMode(selected),
                ),
                const SizedBox(width: 16),
                ChoiceChip(
                  label: const Text('Best of 5'),
                  selected: !isThreeSet,
                  onSelected: (selected) => _setGameMode(!selected),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  // Check for empty fields.
                  if (player1TextField.text.isEmpty ||
                      player2TextField.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill in all the fields.")),
                    );
                    return;
                  }

                  final data = {
                    'p1Name': player1TextField.text,
                    'p2Name': player1TextField.text,
                    'p1serve': isplayer1serve,
                    'threegame': isThreeSet,
                  };
                  context.pushReplacement('/scoreboard', extra: data);
                },
                child: const Text("Start"))
          ],
        ),
      ),
    );
  }
}
