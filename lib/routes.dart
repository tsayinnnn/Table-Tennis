import 'package:go_router/go_router.dart';
import 'package:ttsb/gameinfo.dart';
import 'package:ttsb/scoreboard.dart';
import 'package:ttsb/startgame.dart';

final routes = GoRouter(
  routes: [
    // Start Game Page
    GoRoute(
      path: '/',
      builder: (context, state) => const startGame(),
    ),

    // Game Page
    GoRoute(
      path: '/game',
      builder: (context, state) => game(),
    ),

    // Scoreboard
    GoRoute(
      path: '/scoreboard',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>;
        return scoreboard(
          p1Name: data['p1Name'],
          p2Name: data['p2Name'],
          p1serve: data['p1serve'],
          threegame: data['threegame'],
        );
      },
    ),
  ],
);
