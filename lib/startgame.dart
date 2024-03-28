import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class startGame extends StatefulWidget {
  const startGame({super.key});

  @override
  State<startGame> createState() => _startGameState();
}

class _startGameState extends State<startGame> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //logo
            isDarkMode
                ? Image.asset('assets/logo_dark.png')
                : Image.asset('assets/logo.png'),

            // button navigation
            ElevatedButton(
              onPressed: () => context.push('/game'),
              child: const Text("Start Game"),
            )
          ],
        ),
      ),
    );
  }
}
