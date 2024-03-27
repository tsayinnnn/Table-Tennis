import 'package:flutter/material.dart';
import 'package:ttsb/startgame.dart';

class Winner extends StatelessWidget {
  final String winner;
  const Winner({super.key, required this.winner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Text('$winner + wins'),
        ], //add back to home
      ),
    ));
  }
}
