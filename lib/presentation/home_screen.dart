import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/model.dart';
import 'package:todo/presentation/task_cell.dart';
import 'package:todo/presentation/task_cubit/task_cubit.dart';

import 'add_task_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AddTaskSection(),
        Expanded(
          child:
          BlocBuilder<TaskCubit, TaskState>(builder: (context, state) {
            if (state is TaskUpdated) {
              return ListView(
                children: state.tasks.mapToList(
                      (task) => Dismissible(
                    key: Key(task.text),
                    child: TaskCell(task: task),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        context.read<TaskCubit>().deleteOneTask(task);
                      }
                    },
                  ),
                ),
              );
            }
            return Container();
          }),
        )
      ],
    );
  }
}