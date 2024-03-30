import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ttsb/routes.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() async {
  runApp(
    ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return DynamicColorBuilder(
          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
            // Themes
            final lightTheme = ThemeData(
              colorScheme: lightDynamic,
              brightness: Brightness.light,
            );
            final darkTheme = ThemeData(
              colorScheme: darkDynamic,
              brightness: Brightness.dark,
            );

            // The main app
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.system,
              routerConfig: routes,
            );
          },
        );
      },
    ),
  );
}
