import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../viewmodel/module.dart';
import '../widgets/todo_tile.dart';

class TodosList extends ConsumerWidget {
  static const routeName = '/todos';
  const TodosList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosListState);
    final active = todos.active;
    final completed = todos.completed;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Taskifier 📝', style: TextStyle(fontSize: 24,color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Add logout logic here
              FirebaseAuth.instance.signOut();
            },
          ),
          IconButton(
            onPressed: () {
              context.go('/todos/new');
            },
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
        backgroundColor: Color.fromARGB(235, 14, 134, 239),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: active.isEmpty
                  ? Column(children: [
                      const SizedBox(height: 20),
                      const Text('No todos yet!🥲'),
                      Image.asset('assets/stars.gif',
                          height: 200, fit: BoxFit.fitWidth
                      ),
                  ],)
                  : ListView.builder(
                      itemCount: active.length,
                      itemBuilder: (context, index) {
                        final todo = active[index];
                        return Column(
                          children: [
                            TodoTile(todo: todo),
                          ],
                        );
                      },
                    ),
            ),
            if (completed.isNotEmpty)
              ExpansionTile(
                title: const Text('Completed'),
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: completed.length,
                        itemBuilder: (context, index) {
                          return TodoTile(todo: completed[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
