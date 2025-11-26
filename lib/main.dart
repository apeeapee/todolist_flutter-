import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Futuristic Theme Colors
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color primaryNeon = const Color(0xFF00F0FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mission Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        primaryColor: primaryNeon,
        colorScheme: ColorScheme.dark(
          primary: primaryNeon,
          surface: const Color// filepath: c:\Users\ASUS\Documents\koding mengkoding\MobileDev\todolist\lib\main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  // Ensure Flutter binding is initialized before Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Futuristic Theme Colors
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color primaryNeon = const Color(0xFF00F0FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mission Control',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        primaryColor: primaryNeon,
        colorScheme: ColorScheme.dark(
          primary: primaryNeon,
          surface: const Color(0xFF16213E),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', 
      ),
      // Direct to LoginScreen as the entry point
      home: LoginScreen(),
    );
  }
}