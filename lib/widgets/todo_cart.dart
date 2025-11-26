import 'package:flutter/material.dart';
import '../services/todo_service.dart';
import '../screens/edit_task_bottomsheet.dart';

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
    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => TodoService.deleteTodo(id),
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),

        child: Row(
          children: [
            // CHECKBOX
            Checkbox(
              value: done,
              activeColor: const Color(0xFF6C63FF),
              onChanged: (val) {
                TodoService.toggleDone(id, val!);
              },
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
                      color: done ? Colors.grey : Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),

            // EDIT BUTTON
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF6C63FF)),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
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
