import 'package:equatable/equatable.dart';

class Task extends Equatable {
  /// The text describing the task.
  final String text;

  /// If the task is done or not. The task may be deleted if it is done.
  final bool isDone;

  const Task({
    required this.text,
    this.isDone = false,
  });

  @override
  List<Object?> get props => [text, isDone];

  @override
  String toString() => 'Task(text: $text, isDone: $isDone)';

  Task copyWith({
    String? text,
    bool? isDone,
  }) {
    return Task(
      text: text ?? this.text,
      isDone: isDone ?? this.isDone,
    );
  }
}

extension ListExtension<E> on Iterable<E> {
  List<T> mapToList<T>(T Function(E) mapper) => map(mapper).toList();
}