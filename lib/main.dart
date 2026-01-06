import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/server_list_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/about_screen.dart';

void main() {
  runApp(const ObscurraApp());
}

class ObscurraApp extends StatelessWidget {
  const ObscurraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Obscurra VPN',
      theme: ThemeData(
        primaryColor: const Color(0xFF2C3E50),
        scaffoldBackgroundColor: const Color(0xFFECF0F1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF34495E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/servers': (context) => const ServerListScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
