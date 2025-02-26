import 'package:flutter/material.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:note_taking_app/core/theme.dart';
import 'package:note_taking_app/providers/theme_provider.dart';
import 'package:note_taking_app/screens/home_screen.dart'; // Make sure this file exists

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(create: (context) => NoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}
