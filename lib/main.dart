import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart';

void main() async {
  // Memastikan binding flutter terinisialisasi sebelum Firebase
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Firebase
  await Firebase.initializeApp();
  
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema futuristik
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color primaryNeon = const Color(0xFF00F0FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mission Control',
      // Mengatur tema global agar sesuai dengan desain futuristik
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bgDark,
        primaryColor: primaryNeon,
        colorScheme: ColorScheme.dark(
          primary: primaryNeon,
          surface: const Color(0xFF16213E),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto', // Atau font futuristik lain jika ada
      ),
      // Arahkan home ke LoginScreen, bukan HomePage biasa
      home: const LoginScreen(),
    );
  }
}
