import '../model/task.dart';

// Abstract class representing the base class for all task states
abstract class TaskState {}

// State when tasks are loading
class TaskLoading extends TaskState {}

// State when tasks have been successfully loaded
class TaskLoaded extends TaskState {
  final List<Task> tasks; // The list of tasks loaded

  // Constructor to initialize the tasks list
  TaskLoaded(this.tasks);
}

// State representing an error when fetching tasks, with an error message
class TaskError extends TaskState {
  final String message; // Error message to describe the issue

  // Constructor to initialize the error message
  TaskError(this.message);
}
