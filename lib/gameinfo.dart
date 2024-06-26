// fix requires, ilagay sa arguments (OOP) para magamit sa mismong scoreboard
// fix choice chips (boolean keme)

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  void initState() {
    super.initState();

    Random rng = Random();
    isplayer1serve = rng.nextBool();
    isThreeSet = rng.nextBool();
  }

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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Player Selection", style: textTheme.headlineMedium),
              // input name player 1 and 2
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                child: Column(
                  children: [
                    TextField(
                      controller: player1TextField,
                      decoration:
                          const InputDecoration(labelText: "Player 1 Name"),
                      autofocus: true,
                    ),
                    TextField(
                      controller: player2TextField,
                      decoration:
                          const InputDecoration(labelText: "Player 2 Name"),
                    )
                  ],
                ),
              ),
              Text("First Service:", style: textTheme.bodyLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 12.w),
                  ChoiceChip(
                    label: const Text('Player 1'),
                    selected: isplayer1serve,
                    onSelected: (selected) => _setFirstPlayer(true),
                  ),
                  SizedBox(width: 4.w),
                  ChoiceChip(
                    label: const Text('Player 2'),
                    selected: !isplayer1serve,
                    onSelected: (selected) => _setFirstPlayer(false),
                  ),
                  SizedBox(width: 1.w),
                  IconButton(
                    icon: const FaIcon(FontAwesomeIcons.dice),
                    onPressed: () {
                      Random rng = Random();
                      bool r = rng.nextBool();
                      setState(() {
                        isplayer1serve = r;
                      });
                    },
                  ),
                ],
              ),
              // number of set
              Text("Game Play: ", style: textTheme.bodyLarge),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    label: const Text('Best of 3'),
                    selected: isThreeSet,
                    onSelected: (selected) => _setGameMode(true),
                  ),
                  SizedBox(width: 4.w),
                  ChoiceChip(
                    label: const Text('Best of 5'),
                    selected: !isThreeSet,
                    onSelected: (selected) => _setGameMode(false),
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

                  // Go to the scoreboard
                  // NOTE: You can't go back, hence .pushReplacement()
                  // use .push() or .go() to remove this feature.
                  final data = {
                    'p1Name': player1TextField.text,
                    'p2Name': player2TextField.text,
                    'p1serve': isplayer1serve,
                    'threegame': isThreeSet,
                  };
                  context.pushReplacement('/scoreboard', extra: data);
                },
                child: const Text("Start"),
              ),

              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
