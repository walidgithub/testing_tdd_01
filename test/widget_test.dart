import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/domain/model.dart';

import 'package:todo/main.dart';
import 'package:todo/presentation/task_cell.dart';

extension FinderExtension on Finder {
  Widget accessFirstWidget() => evaluate().first.widget;
  E accessFirstWidgetAs<E extends Widget>() => accessFirstWidget() as E;
}

void main() {

  Future<void> addTask(
      WidgetTester tester, {
        String taskText = "Finish Widget tests",
      }) async {
    await tester.pumpWidget(const MyApp());

    final textField = find.byType(TextField);

    expect(textField, findsOneWidget);
    expect(find.byType(TaskCell), findsNothing);
    await tester.enterText(textField, taskText);
    await tester.tap(find.text("Add task"));

    await tester.pumpAndSettle();
  }

  // add task
  group("Adding one task", () {
    testWidgets(
      "Find a TextField, enter text in it, and find a button with text 'Add', and then tap it to find a new TaskCell created.",
          (tester) async {
        // Create the widget by telling the tester to build it.
        await tester.pumpWidget(const MyApp());

        // Find a TextField
        final textField = find.byType(TextField);
        const taskText = "Finish Widget tests";

        // Textfield should be empty
        expect(
            (textField.evaluate().first.widget as TextField).controller == null,
            false);
        expect(
          (textField.evaluate().first.widget as TextField).controller?.text ??
              "Not empty",
          "",
        );

        // using matcher
        // expect to Find a TextField
        expect(textField, findsOneWidget);
        // expect to Find no tasks
        expect(find.byType(TaskCell), findsNothing);
        // expect to Enter text in it with taskText
        await tester.enterText(textField, taskText);

        // TextField should not be empty.
        expect(
          (textField.evaluate().first.widget as TextField).controller?.text ??
              "Not empty",
          taskText,
        );

        // and then tap it to find a new TaskCell created.
        await tester.tap(find.text("Add task"));
        // to complete test
        await tester.pumpAndSettle();

        // TextField should have been emptied.
        expect(
          (textField.evaluate().first.widget as TextField).controller?.text ??
              "Not empty",
          "",
        );

        // expect to Find tasks
        expect(find.byType(TaskCell), findsOneWidget);
      },
    );
  });

  // make task done
  group("Complete one task", () {
    testWidgets("Complete one task, and verify that the correct icon is showed",
            (tester) async {
          const taskText = "Finish test widgets";

          await addTask(tester, taskText: taskText);

          final taskCell = find.byType(TaskCell);
          expect(taskCell, findsOneWidget);

          expect(find.byType(IconButton), findsOneWidget);
          expect(find.byIcon(Icons.circle), findsOneWidget);

          await tester.tap(find.byType(IconButton));
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.check), findsOneWidget);
          expect(
            taskCell.accessFirstWidgetAs<TaskCell>().task,
            const Task(text: taskText, isDone: true),
          );
        });
  });

  // delete task
  group("Delete one task : ", () {
    testWidgets("", (tester) async {
      const taskText = "Finish test widgets";

      await addTask(tester, taskText: taskText);

      final taskCell = find.byType(TaskCell);
      expect(taskCell, findsOneWidget);

      await tester.drag(
        taskCell,
        const Offset(-500, 0),
      );
      await tester.pumpAndSettle();

      expect(taskCell, findsNothing);
    });
  });
}
