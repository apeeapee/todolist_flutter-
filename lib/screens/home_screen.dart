import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../services/auth_service.dart';
import '../widgets/todo_card.dart';
import 'add_task_bottomsheet.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("My Tasks",
            style: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              await AuthService.logout();
              Navigator.pop(context);
            },
          ),
        ],
      ),

      // LIST OF TASKS
      body: StreamBuilder(
        stream: TodoService.getTodos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text(
                "Belum ada task.\nTekan tombol + untuk menambah.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
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
              );
            },
          );
        },
      ),

      // ADD BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6C63FF),
        child: const Icon(Icons.add, size: 32),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            ),
            builder: (_) => AddTaskBottomSheet(),
          );
        },
      ),
    );
  }
}
