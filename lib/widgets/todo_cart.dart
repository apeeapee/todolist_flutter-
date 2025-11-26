import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../screens/edit_task.dart';

class ToDoCard extends StatelessWidget {
  final String id;
  final String text;
  final bool done;
  final String category;

  const ToDoCard({
    super.key,
    required this.id,
    required this.text,
    required this.done,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryNeon = const Color(0xFF00F0FF); // Cyan Neon
    final Color cardDark = const Color(0xFF16213E);

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => TodoService.deleteTodo(id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red, width: 1),
        ),
        child: const Icon(Icons.delete, color: Colors.red),
      ),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: cardDark,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: done ? Colors.grey.withOpacity(0.2) : primaryNeon.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: done ? Colors.transparent : primaryNeon.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),

        child: Row(
          children: [
            // CHECKBOX
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: done,
                activeColor: primaryNeon,
                checkColor: Colors.black,
                side: BorderSide(color: primaryNeon, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (val) {
                  TodoService.toggleDone(id, val!);
                },
              ),
            ),

            // TEXT & CATEGORY
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 17,
                      decoration: done ? TextDecoration.lineThrough : null,
                      decorationColor: primaryNeon,
                      decorationThickness: 2,
                      color: done ? Colors.grey : Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: primaryNeon.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      category.toUpperCase(),
                      style: TextStyle(
                        color: primaryNeon,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),

            // EDIT BUTTON
            IconButton(
              icon: Icon(Icons.edit, color: primaryNeon.withOpacity(0.8)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => EditTaskBottomSheet(
                    id: id,
                    oldText: text,
                    oldCategory: category,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
