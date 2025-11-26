import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../services/auth_service.dart';
import '../widgets/todo_cart.dart';
import 'Add_task.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using a dark theme palette for a futuristic look
    final Color primaryNeon = const Color(0xFF00F0FF); // Cyan Neon
    final Color bgDark = const Color(0xFF1A1A2E);

    return Scaffold(
      backgroundColor: bgDark,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("MISSION CONTROL",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: primaryNeon.withOpacity(0.8),
                  blurRadius: 15,
                )
              ],
            )),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new, color: primaryNeon),
            onPressed: () async {
              await AuthService.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),

      // LIST OF TASKS
      body: StreamBuilder<QuerySnapshot>(
        stream: TodoService.getTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: primaryNeon));
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.rocket_launch,
                      size: 80, color: Colors.grey.withOpacity(0.2)),
                  const SizedBox(height: 20),
                  Text(
                    "NO ACTIVE MISSIONS\nINITIALIZE NEW OBJECTIVE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.5),
                        fontSize: 16,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, i) {
              var data = docs[i];
              return ToDoCard(
                id: data.id,
                text: data["text"],
                done: data["done"],
                category: data.data().toString().contains('category')
                    ? data["category"]
                    : "Personal",
              );
            },
          );
        },
      ),

      // ADD BUTTON
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryNeon.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: FloatingActionButton(
          backgroundColor: primaryNeon,
          child: const Icon(Icons.add, size: 32, color: Colors.black),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => AddTaskBottomSheet(),
            );
          },
        ),
      ),
    );
  }
}
