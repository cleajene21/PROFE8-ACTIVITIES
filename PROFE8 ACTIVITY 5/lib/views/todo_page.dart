import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTask(BuildContext context) {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    context.read<TodoProvider>().add(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final todoProv = context.watch<TodoProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
        backgroundColor: const Color(0xFFE91E63),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addTask(context),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63)),
                  onPressed: () => _addTask(context),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                if (todoProv.todos.isEmpty)
                  const Center(child: Text('No tasks yet')),
                ...todoProv.todos.map((t) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: t.done,
                        onChanged: (_) =>
                            context.read<TodoProvider>().toggle(t.id),
                        activeColor: const Color(0xFFE91E63),
                      ),
                      title: Text(
                        t.title,
                        style: TextStyle(
                            decoration:
                                t.done ? TextDecoration.lineThrough : null),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () =>
                            context.read<TodoProvider>().remove(t.id),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE91E63)),
                  onPressed: () =>
                      context.read<TodoProvider>().clearCompleted(),
                  child: const Text('Clear completed'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () => context.read<TodoProvider>().clearAll(),
                  child: const Text('Clear all'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
