import 'package:flutter/material.dart';
import 'package:ttsb/routes.dart';

void main() async {
  runApp(const TTSB());
}

class TTSB extends StatelessWidget {
  const TTSB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: routes,
    );
  }
}
