import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/task_cubit/task_cubit.dart';

import '../domain/model.dart';

class TaskCell extends StatelessWidget {
  final Task task;

  const TaskCell({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(task.text),
        ),
        IconButton(
          onPressed: () => context.read<TaskCubit>().completeOneTask(task),
          icon: Icon(
            task.isDone ? Icons.check : Icons.circle,
          ),
        )
      ],
    );
  }
}