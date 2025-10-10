import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String id;
  final String title;
  bool done;

  Todo({
    required this.id,
    required this.title,
    this.done = false,
  });
}

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void add(String title) {
    if (title.trim().isEmpty) return;
    _todos.add(Todo(id: const Uuid().v4(), title: title.trim()));
    notifyListeners();
  }

  void toggle(String id) {
    final t =
        _todos.firstWhere((e) => e.id == id, orElse: () => throw 'Not found');
    t.done = !t.done;
    notifyListeners();
  }

  void remove(String id) {
    _todos.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  void clearCompleted() {
    _todos.removeWhere((t) => t.done);
    notifyListeners();
  }

  // ✅ ADD THIS METHOD TO FIX THE ERROR
  void clearAll() {
    _todos.clear();
    notifyListeners();
  }
}
