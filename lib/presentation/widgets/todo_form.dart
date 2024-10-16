import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoForm extends ConsumerWidget {
  const TodoForm(
      {super.key,
      required this.titleController,
      required this.descriptionController});
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          labelText: 'Title',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            } else {
              return null;
            }
          },
        ),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
          ),
        ),
      ],
    );
  }
}
