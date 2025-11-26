import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Color primaryNeon = const Color(0xFF00F0FF);
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color cardDark = const Color(0xFF16213E);

    return Scaffold(
      backgroundColor: bgDark,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add_alt_1, size: 80, color: primaryNeon),
              const SizedBox(height: 20),
              Text(
                "NEW IDENTITY",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(color: primaryNeon.withOpacity(0.8), blurRadius: 15)
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Email Input
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "EMAIL ADDRESS",
                  labelStyle: TextStyle(color: primaryNeon),
                  filled: true,
                  fillColor: cardDark,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryNeon),
                  ),
                  prefixIcon: Icon(Icons.email, color: primaryNeon),
                ),
              ),
              const SizedBox(height: 20),

              // Password Input
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "SET ACCESS CODE",
                  labelStyle: TextStyle(color: primaryNeon),
                  filled: true,
                  fillColor: cardDark,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryNeon),
                  ),
                  prefixIcon: Icon(Icons.lock, color: primaryNeon),
                ),
              ),
              const SizedBox(height: 40),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          setState(() => isLoading = true);
                          try {
                            await AuthService.register(
                                emailController.text, passwordController.text);
                            Navigator.pop(context); // Kembali ke login
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Identity Established! Please Login."),
                                backgroundColor: primaryNeon.withOpacity(0.8),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.red.withOpacity(0.8),
                              ),
                            );
                          } finally {
                            setState(() => isLoading = false);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryNeon,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                    shadowColor: primaryNeon.withOpacity(0.5),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          "ESTABLISH IDENTITY",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Abort Registration",
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
