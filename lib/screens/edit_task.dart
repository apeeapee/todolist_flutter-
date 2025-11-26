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
    // Using a dark theme palette for a futuristic look
    final Color primaryNeon = const Color(0xFF00F0FF); // Cyan Neon
    final Color bgDark = const Color(0xFF1A1A2E);
    final Color cardDark = const Color(0xFF16213E);

    return Container(
      decoration: BoxDecoration(
        color: bgDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: primaryNeon.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 5,
          )
        ],
      ),
      padding: EdgeInsets.only(
        left: 22,
        right: 22,
        top: 22,
        bottom: MediaQuery.of(context).viewInsets.bottom + 22,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "UPDATE MISSION",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.5,
              shadows: [
                Shadow(
                  color: primaryNeon.withOpacity(0.5),
                  blurRadius: 10,
                )
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Task Input
          Text("TASK NAME",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              hintText: "Enter objective...",
              hintStyle: TextStyle(color: Colors.grey[600]),
              fillColor: cardDark,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primaryNeon, width: 2),
              ),
              prefixIcon: Icon(Icons.edit, color: primaryNeon),
            ),
          ),
          const SizedBox(height: 20),

          // Category Dropdown
          Text("CATEGORY",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            value: category,
            dropdownColor: cardDark,
            style: const TextStyle(color: Colors.white),
            icon: Icon(Icons.keyboard_arrow_down, color: primaryNeon),
            items: categories.map((e) {
              return DropdownMenuItem(value: e, child: Text(e));
            }).toList(),
            onChanged: (v) => setState(() => category = v!),
            decoration: InputDecoration(
              filled: true,
              fillColor: cardDark,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: primaryNeon, width: 2),
              ),
              prefixIcon: Icon(Icons.category, color: primaryNeon),
            ),
          ),

          const SizedBox(height: 30),

          // Action Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryNeon.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                TodoService.updateTodo(widget.id, controller.text, category);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryNeon,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text("UPDATE SYSTEM",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1)),
            ),
          )
        ],
      ),
    );
  }
}
