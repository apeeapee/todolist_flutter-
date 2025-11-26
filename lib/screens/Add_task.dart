import 'package:flutter/material.dart';
import '../services/todo_service.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final controller = TextEditingController();
  String selectedCategory = "Personal";

  final categories = [
    "Personal",
    "Work",
    "Study",
    "Shopping",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Tambah Task",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              hintText: "Tulis task...",
              fillColor: const Color(0xFFF6F6F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // CATEGORY DROPDOWN
          DropdownButtonFormField(
            value: selectedCategory,
            items: categories.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (v) => setState(() => selectedCategory = v!),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF6F6F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  TodoService.addTodo(controller.text, selectedCategory);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Tambah Task",
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}
