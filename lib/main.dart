import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttsb/routes.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  runApp(ResponsiveSizer(builder: (context, orientation, screenType) {
    return AdaptiveTheme(
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        initial: AdaptiveThemeMode.light,
        builder: (theme, darkTheme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme,
            darkTheme: darkTheme,
            routerConfig: routes,
          );
        });
  }));
}
