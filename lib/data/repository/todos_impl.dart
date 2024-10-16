import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:todolite/domain/model/todo.dart';

import '../../domain/model/todos.dart';
import '../../domain/repository/todos.dart';
import '../source/files/files.dart';

class TodoRepositoryImpl extends TodosRepository {
  TodoRepositoryImpl(this.files);
  final Files files;
  late final String path = 'Todos.json';

  @override
  Future<void> deleteAllTodos() async {
    await files.delete(path);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await loadTodos();

    final newTodos = todos.values.where((td) => td.id != id).toList();

    await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
  }

  @override
  Future<Todo?> getTodoById(String id) async {
    final todos = await loadTodos();

    return todos.values.firstWhereOrNull((todo) => todo.id == id);
  }

  Future<Todos> loadTodos() async {
    final content = await files.read(path);

    if (content == null || content.isEmpty) {
      // Return an empty Todos list if no content is found
      return const Todos(values: []);
    }

    try {
      return Todos.fromJson(
          jsonDecode(content)); // Try to parse the JSON content
    } catch (e) {
      print('Error decoding JSON: $e');
      // Handle the error by returning an empty Todos object
      return const Todos(values: []);
    }
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final todos = await loadTodos();

    final existingTodo =
        todos.values.firstWhereOrNull((td) => td.id == todo.id);
    if (existingTodo != null) {
      final newTodo = existingTodo.copyWith(
        title: todo.title,
        description: todo.description,
        completed: todo.completed,
      );
      final newTodos = todos.values.map((td) {
        return td.id == todo.id ? newTodo : td;
      }).toList();
      await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
    } else {
      final newTodos = [...todos.values, todo];
      await files.write(path, jsonEncode(Todos(values: newTodos).toJson()));
    }
  }
}
