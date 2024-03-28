import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttsb/routes.dart';
import 'package:ttsb/theme.dart';

void main() async {
  runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
    return EasyDynamicThemeWidget(child: const TTSB());
  }));
}

class TTSB extends StatelessWidget {
  const TTSB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      routerConfig: routes,
    );
  }
}
