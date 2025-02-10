import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowithblocandsql/bloc/task_event.dart';
import '../model/task.dart';
import '../repository/sqlhelper.dart';

// Abstract class for different task states
abstract class TaskState {}

// State representing that tasks are loading
class TaskLoading extends TaskState {}

// State representing that tasks have been successfully loaded
class TaskLoaded extends TaskState {
  final List<Task> tasks; // A list of tasks to display
  TaskLoaded(this.tasks); // Constructor to initialize the tasks list
}

// State representing an error occurred while loading tasks
class TaskError extends TaskState {
  final String error; // Error message to display
  TaskError(this.error); // Constructor
}

// The TaskBloc handles the business logic for managing tasks
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  // Constructor that initializes the state to TaskLoading and registers event handlers
  TaskBloc() : super(TaskLoading()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<FilterTasks>(_onFilterTasks);
  }

  // Event handler for loading tasks
  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    try {
      // Fetch tasks from the database
      final tasks = await DBHelper.getTasks();
      // Emit a TaskLoaded state with the tasks fetched
      emit(TaskLoaded(tasks));
    } catch (e) {
      // If an error occurs, emit a TaskError state
      emit(TaskError("Failed to load tasks"));
    }
  }

  // Event handler for adding a new task
  Future<void> _onAddTask(AddTask event, Emitter<TaskState> emit) async {
    // Insert the new task into the database
    await DBHelper.insertTask(event.task);
    // After adding the task, reload all tasks to update the UI
    add(LoadTasks());
  }

  // Event handler for updating an existing task
  Future<void> _onUpdateTask(UpdateTask event, Emitter<TaskState> emit) async {
    // Update the task in the database
    await DBHelper.updateTask(event.task);
    // After updating, reload all tasks to reflect changes in the UI
    add(LoadTasks());
  }

  // Event handler for deleting a task
  Future<void> _onDeleteTask(DeleteTask event, Emitter<TaskState> emit) async {
    // Delete the task from the database by its ID
    await DBHelper.deleteTask(event.id);
    // After deleting, reload all tasks to update the UI
    add(LoadTasks());
  }

  // Event handler for filtering tasks based on completion status
  Future<void> _onFilterTasks(
      FilterTasks event, Emitter<TaskState> emit) async {
    try {
      // Fetch tasks from the database
      final tasks = await DBHelper.getTasks();
      List<Task> filteredTasks;

      // Filter tasks based on completion status
      if (event.isCompleted == null) {
        filteredTasks = tasks; // Show all tasks if no filter is applied
      } else {
        filteredTasks = tasks
            .where((task) => task.isCompleted == event.isCompleted)
            .toList(); // Filter tasks by completion status
      }
      // Emit the filtered tasks
      emit(TaskLoaded(filteredTasks));
    } catch (e) {
      // If an error occurs, emit a TaskError state
      emit(TaskError("Failed to load tasks"));
    }
  }
}
