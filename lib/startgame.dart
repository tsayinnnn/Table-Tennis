import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class startGame extends StatelessWidget {
  const startGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //logo
            Image.asset('assets/logo.png'),

            // button navigation
            ElevatedButton(
              onPressed: () => context.go('/game'),
              child: const Text("Start Game"),
            )
          ],
        ),
      ),
    );
  }
}
