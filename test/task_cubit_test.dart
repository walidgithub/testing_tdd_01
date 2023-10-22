import 'package:flutter_test/flutter_test.dart';
import 'package:todo/domain/model.dart';
import 'package:todo/presentation/task_cubit/task_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group("BLoC tests for the task cubit.", () {
    // add new task
    const task = Task(text: "First task");

    blocTest<TaskCubit, TaskState>(
      'emits [TaskUpdated] when addOneTask is called.',
      // it start with initial state there is no calling for TaskUpdated state yet (TaskUpdated called after running addOneTask function)
      // we will send this state >> TaskInitial >> that call TaskUpdated that returns tasks list
      seed: () => TaskInitial(),
      build: () => TaskCubit(),
      // run function addOneTask and emit TaskUpdated
      act: (cubit) => cubit.addOneTask(task),
      // expected data >> it return expected data after addition "First task"
      expect: () => <TaskState>[
        const TaskUpdated(tasks: <Task>[task])
      ],
    );

    // next test
    // add new task
    const secondTask = Task(text: "Second task");

    blocTest<TaskCubit, TaskState>(
      'given a TaskUpdated with one task, emits [TaskUpdated] when addOneTask is called.',
      // start with data after adding "First task"
      // we will send this state >> TaskUpdated with data >> that call TaskUpdated again that returns tasks list
      seed: () => const TaskUpdated(tasks: [task]),
      build: () => TaskCubit(),
      act: (cubit) => cubit.addOneTask(secondTask),
      // expected data >> it return expected data after addition "First task" and "Second task"
      expect: () => <TaskState>[
        const TaskUpdated(tasks: [task, secondTask])
      ],
    );

    // next test update task to be done
    blocTest<TaskCubit, TaskState>(
      'emits [TaskUpdated] when completeOneTask is added.',
      // start with state that return data >> TaskUpdated state
      // we will send this state >> TaskUpdated with data >> that call TaskUpdated again that returns tasks list
      seed: () => const TaskUpdated(
          tasks: [Task(text: "1"), Task(text: "2"), Task(text: "3")]),
      build: () => TaskCubit(),
      // run function completeOneTask to update data (update action in body of function)
      act: (cubit) => cubit.completeOneTask(const Task(text: "2")),
      // expected data >> it return expected data after update
      expect: () => <TaskState>[
        const TaskUpdated(tasks: [
          Task(text: "1"),
          Task(text: "2", isDone: true),
          Task(text: "3")
        ])
      ],
    );

    // next text
    // test if we sent TaskInitial and completeOneTask that don't return TaskInitial so test will pass
    blocTest<TaskCubit, TaskState>(
      'Given a TaskInitial, emits [] when completeOneTask is added.',
      seed: () => TaskInitial(),
      build: () => TaskCubit(),
      act: (cubit) => cubit.completeOneTask(const Task(text: "2")),
      expect: () => <TaskState>[],
    );

    // next text
    // test if we send empty list and you want to update a task >> it fails
    blocTest<TaskCubit, TaskState>(
      'Given a TaskUpdated with 0 task, emits [] when completeOneTask is added.',
      seed: () => const TaskUpdated(tasks: []),
      build: () => TaskCubit(),
      act: (cubit) => cubit.completeOneTask(const Task(text: "2")),
      expect: () => <TaskState>[],
    );

    // deleting task --------------------------------------------------------------------------
    // tests for delete task
    blocTest<TaskCubit, TaskState>(
      'Given a TaskUpdated with 3 tasks, emits [TaskUpdated] when deleteOneTask is called, with a task contained in the list.',
      seed: () => const TaskUpdated(
          tasks: [Task(text: "1"), Task(text: "2"), Task(text: "3")]),
      build: () => TaskCubit(),
      act: (cubit) => cubit.deleteOneTask(const Task(text: "1")),
      // expected data >> it return expected data after delete
      expect: () => <TaskState>[
        const TaskUpdated(tasks: [Task(text: "2"), Task(text: "3")])
      ],
    );

    // call delete task when we send TaskInitial that don't call TaskInitial
    blocTest<TaskCubit, TaskState>(
      'Given a TaskInitial, emits [TaskUpdated] when deleteOneTask is called.',
      seed: () => TaskInitial(),
      build: () => TaskCubit(),
      act: (cubit) => cubit.deleteOneTask(const Task(text: "1")),
      // expected data >> it return expected data after delete
      expect: () => <TaskState>[],
    );

    // test to delete not found task
    blocTest<TaskCubit, TaskState>(
      'Given a TaskUpdated with 3 tasks, emits [TaskUpdated] when deleteOneTask is called, with a task is NOT contained in the list.',
      seed: () => const TaskUpdated(
          tasks: [Task(text: "0"), Task(text: "2"), Task(text: "3")]),
      build: () => TaskCubit(),
      act: (cubit) => cubit.deleteOneTask(const Task(text: "1")),
      // expected data >> it return expected data after delete
      expect: () => <TaskState>[],
    );
  });
}