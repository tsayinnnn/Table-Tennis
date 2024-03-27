import 'package:flutter/material.dart';
import 'package:ttsb/startgame.dart';

void main() async {
  runApp(const TTSB());
}

class TTSB extends StatelessWidget {
  const TTSB({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      home: startGame(),
    );
  }
}
