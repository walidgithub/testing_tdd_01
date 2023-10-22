import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/task_cubit/task_cubit.dart';

import '../domain/model.dart';

class AddTaskSection extends StatelessWidget {
  const AddTaskSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter your task..."),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<TaskCubit>().addOneTask(Task(text: controller.text));
            controller.text = "";
          },
          child: const Text("Add task"),
        )
      ],
    );
  }
}
