import '../model/task.dart';

// Abstract base class for Task events
abstract class TaskEvent {}

// Event to load all tasks from the database
class LoadTasks extends TaskEvent {}

// Event to add a new task to the database
class AddTask extends TaskEvent {
  final Task task; // The task that needs to be added
  AddTask(this.task); // Constructor to initialize the task
}

// Event to update an existing task in the database
class UpdateTask extends TaskEvent {
  final Task task; // The task that needs to be updated
  UpdateTask(this.task);
}

// Event to delete a task from the database by its ID
class DeleteTask extends TaskEvent {
  final int id; // The ID of the task to be deleted
  DeleteTask(this.id);
}

// Event to filter tasks based on their completion status
class FilterTasks extends TaskEvent {
  final bool? isCompleted; // The completion status to filter tasks by
  FilterTasks(this.isCompleted); // Constructor to initialize the completion status filter
}
