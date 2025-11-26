import 'package:flutter/material.dart';
import '../services/todo_service.dart';

class EditTaskBottomSheet extends StatefulWidget {
  final String id;
  final String oldText;
  final String oldCategory;

  const EditTaskBottomSheet({
    super.key,
    required this.id,
    required this.oldText,
    required this.oldCategory,
  });

  @override
  State<EditTaskBottomSheet> createState() => _EditTaskBottomSheetState();
}

class _EditTaskBottomSheetState extends State<EditTaskBottomSheet> {
  late TextEditingController controller;
  late String category;

  final categories = [
    "Personal",
    "Work",
    "Study",
    "Shopping",
    "Other"
  ];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.oldText);
    category = widget.oldCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Edit Task",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          TextField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              hintText: "Tulis task...",
              fillColor: Color(0xFFF6F6F9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          DropdownButtonFormField(
            value: category,
            items: categories.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (v) => setState(() => category = v!),
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
                TodoService.updateTodo(widget.id, controller.text, category);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                "Simpan Perubahan",
                style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
