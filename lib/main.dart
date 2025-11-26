import 'package:flutter/material.dart';

void main() {
  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _tasks = [];

  void addTask() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _tasks.add({
        "title": _controller.text,
        "done": false,
      });
    });
    _controller.clear();
  }

  void toggleTask(int index) {
    setState(() {
      _tasks[index]["done"] = !_tasks[index]["done"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Input Task
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Tambah Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTask,
                  child: const Text("Add"),
                ),
              ],
            ),
          ),

          // List Task
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: _tasks[index]["done"],
                    onChanged: (value) => toggleTask(index),
                  ),
                  title: Text(
                    _tasks[index]["title"],
                    style: TextStyle(
                      decoration: _tasks[index]["done"]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteTask(index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
