import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class scoreboard extends StatefulWidget {
  final String p1Name;
  final String p2Name;
  bool p1serve;
  final bool threegame;

  scoreboard({
    super.key,
    required this.p1Name,
    required this.p2Name,
    required this.p1serve,
    required this.threegame,
  });

  @override
  State<scoreboard> createState() => _scoreboardState();
}

class _scoreboardState extends State<scoreboard> {
  int player1Score = 0;
  int player2Score = 0;
  int player1Set = 0;
  int player2Set = 0;
  String setScore = "";
  late bool serve;

  @override
  void initState() {
    super.initState();
    serve = widget.p1serve;
  }

  void addPlayer1Score(BuildContext context) {
    setState(() {
      player1Score++;
      if ((player1Score + player2Score) % 2 == 0) {
        serve = !serve;
      }
      if ((player1Score >= 11 && player1Score - player2Score >= 2) ||
          (player1Score > 10 &&
              player2Score > 10 &&
              player1Score - player2Score == 2)) {
        player1Set++;
        recordScore();
        resetScore(context);
      }
    });
  }

  void addPlayer2Score(BuildContext context) {
    setState(() {
      player2Score++;
      if ((player1Score + player2Score) % 2 == 0) {
        serve = !serve;
      }
      if ((player2Score >= 11 && player2Score - player1Score >= 2) ||
          (player1Score > 10 &&
              player2Score > 10 &&
              player2Score - player1Score == 2)) {
        player2Set++;
        recordScore();
        resetScore(context);
      }
    });
  }

  void recordScore() {
    setScore = "$player1Score - $player2Score";
  }

  void reducePlayer1Score() {
    setState(() {
      if (player1Score > 0) {
        player1Score--;
        if ((player1Score + player2Score) % 2 != 0) {
          serve = !serve;
        }
      }
    });
  }

  void reducePlayer2Score() {
    setState(() {
      if (player2Score > 0) {
        player2Score--;
        if ((player1Score + player2Score) % 2 != 0) {
          serve = !serve;
        }
      }
    });
  }

  void resetScore(BuildContext context) {
    player1Score = 0;
    player2Score = 0;
    gameSet(context);
  }

  void gameSet(BuildContext context) async {
    if (widget.threegame) {
      if (player1Set >= 2) {
        await showWinner(context, widget.p1Name);
      } else if (player2Set >= 2) {
        await showWinner(context, widget.p2Name);
      }
    } else {
      if (player1Set >= 3) {
        await showWinner(context, widget.p1Name);
      } else if (player2Set >= 3) {
        await showWinner(context, widget.p2Name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.rightToBracket),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("New Game?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () => context.pop(),
                    ),
                    TextButton(
                      child: const Text("Confirm"),
                      onPressed: () => context.pushReplacement('/'),
                    )
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //  crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 100,
              height: 100,
            ),
            //content columns

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //row 1 - 1serve and set score
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color:
                              serve ? Colors.green : colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    //score board a
                    Container(
                      width: 13.w,
                      height: 13.w,
                      decoration: BoxDecoration(
                          color: colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          '$player1Set',
                          style: textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                //row 2- s1 name, score, row of buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.p1Name),
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          '$player1Score',
                          style: textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () => addPlayer1Score(context),
                            child: const FaIcon(FontAwesomeIcons.plus),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: reducePlayer1Score,
                          child: const FaIcon(FontAwesomeIcons.minus),
                        ),
                      ],
                    ),
                  ],
                ),
                //row 3 - s2 name, score, row of buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.p2Name),
                    Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          '$player2Score',
                          style: textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            onPressed: () => addPlayer2Score(context),
                            child: const FaIcon(FontAwesomeIcons.plus),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: reducePlayer2Score,
                          child: const FaIcon(FontAwesomeIcons.minus),
                        ),
                      ],
                    ),
                  ],
                ),
                //row 4 - 2serve and set score
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color:
                              serve ? colorScheme.surfaceVariant : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      width: 13.w,
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          '$player2Set',
                          style: textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              width: 32.w,
              height: 7.5.h,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                children: [
                  const Text("Previous score:"),
                  Text(setScore, style: textTheme.labelLarge),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showWinner(BuildContext context, String name) async {
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("$name wins!"),
        icon: const Center(child: FaIcon(FontAwesomeIcons.trophy)),
        actions: [
          TextButton(
            child: const Text("Confirm"),
            onPressed: () => context.pop(),
          ),
        ],
      );
    },
  );
  context.pushReplacement('/');
}
