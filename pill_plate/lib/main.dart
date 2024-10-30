import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'layout/main_layout.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          primary: Colors.blue,
          secondary: Colors.lightBlueAccent,
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      routes: {
        '/home': (context) => MainLayout(content: HomeScreen()),
        '/profile': (context) => MainLayout(content: ProfileScreen()),
        '/settings': (context) => MainLayout(content: SettingsScreen()),
      },
    );
  }
}
