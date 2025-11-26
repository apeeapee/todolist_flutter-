import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Using a dark theme palette for a futuristic look
    final Color primaryNeon = const Color(0xFF00F0FF); // Cyan Neon
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color cardDark = const Color(0xFF16213E);

    return Scaffold(
      backgroundColor: bgDark,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.security, size: 80, color: primaryNeon),
              const SizedBox(height: 20),
              Text(
                "ACCESS PORTAL",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      color: primaryNeon.withOpacity(0.8),
                      blurRadius: 20,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Identify yourself to proceed",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 50),

              // Email
              TextField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "USER ID / EMAIL",
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
                  filled: true,
                  fillColor: cardDark,
                  prefixIcon: Icon(Icons.email_outlined, color: primaryNeon),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryNeon, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                controller: password,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "ACCESS CODE",
                  labelStyle: TextStyle(color: Colors.grey[500], fontSize: 12),
                  filled: true,
                  fillColor: cardDark,
                  prefixIcon: Icon(Icons.lock_outline, color: primaryNeon),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryNeon, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Login Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: primaryNeon.withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await AuthService.login(email.text, password.text);
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => HomeScreen()));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Access Denied: ${e.toString()}"),
                          backgroundColor: Colors.red.withOpacity(0.8),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryNeon,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text("INITIATE LOGIN",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1)),
                ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    children: [
                      const TextSpan(text: "New User? "),
                      TextSpan(
                        text: "Create Identity",
                        style: TextStyle(
                          color: primaryNeon,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: primaryNeon,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
