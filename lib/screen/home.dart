import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../model/task.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for home screen with title and filter button
      appBar: AppBar(
        title: Text(
          'Task Updation App', // App title
          style: GoogleFonts.expletusSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal, // Set AppBar background color
        actions: [
          // Button for opening task filter options
          IconButton(
            icon: Icon(
              Icons.filter_list, // Filter icon
              color: Colors.white,
            ),
            onPressed: () {
              showFilterDialog(context); // Open filter dialog
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>( // Listen to changes in TaskBloc state
        builder: (context, state) {
          //Datas are in Loading state show a loading spinner
          if (state is TaskLoading) {
            return Center(child: CircularProgressIndicator());
          }
          // When tasks are successfully loaded, show them in a ListView
          else if (state is TaskLoaded) {
            return ListView.builder(
              itemCount: state.tasks.length, // Number of tasks to display
              itemBuilder: (context, index) {
                final task = state.tasks[index]; // Get the task at the current index
                return Card(
                  child: ListTile(
                    title: Text(
                      task.title, // Display task title
                      style: GoogleFonts.expletusSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.green[900], // Title color
                      ),
                    ),
                    subtitle: Text(
                      task.description, // Display task description
                      style: GoogleFonts.expletusSans(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black, // Description color
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Display a check/cross icon based on task completion status
                        IconButton(
                          icon: Icon(
                            task.isCompleted
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: task.isCompleted ? Colors.green : Colors.red,
                          ),
                          onPressed: () {
                            showTaskDialog(context, task); // Open task edit dialog
                          },
                        ),
                        // Edit task button
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            showTaskDialog(context, task); // Open task edit dialog
                          },
                        ),
                        // Delete task button
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.brown,
                          ),
                          onPressed: () {
                            context.read<TaskBloc>().add(DeleteTask(task.id!)); // Dispatch delete task event
                          },
                        ),
                      ],
                    ),
                    onTap: () => showTaskDialog(context, task), // Open task dialog when tapped
                  ),
                );
              },
            );
          }
          // Display a failure message if no tasks are loaded
          else {
            return Center(
                child: Text(
                  "Failed to load tasks", // Error message when no tasks are available
                ));
          }
        },
      ),

      // Floating action button to add new tasks
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add, // Add icon for creating a new task
          color: Colors.white,
        ),
        backgroundColor: Colors.teal, // Floating action button background color
        onPressed: () => showTaskDialog(context, null), // Open task dialog for adding a new task
      ),
    );
  }

  // Show a dialog for filtering tasks (Completed, Pending, All Tasks)
  void showFilterDialog(BuildContext context) {
    bool isAllSelected = true; // Track the "All Tasks" state

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Filter Tasks", // Dialog title
            style: GoogleFonts.expletusSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal[900],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Filter by Completed tasks
              RadioListTile<bool>(
                title: Text(
                  "Completed",
                  style: GoogleFonts.expletusSans(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                value: true,
                groupValue: null,
                onChanged: (value) {
                  context.read<TaskBloc>().add(FilterTasks(true)); // Filter completed tasks
                  Navigator.pop(context); // Close the filter dialog
                },
              ),
              // Filter by Pending tasks
              RadioListTile<bool>(
                title: Text(
                  "Pending",
                  style: GoogleFonts.expletusSans(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                value: false,
                groupValue: null,
                onChanged: (value) {
                  context.read<TaskBloc>().add(FilterTasks(false)); // Filter pending tasks
                  Navigator.pop(context); // Close the filter dialog
                },
              ),
              // Checkbox to show all tasks
              StatefulBuilder(
                builder: (context, setState) {
                  return CheckboxListTile(
                    title: Text(
                      "All Tasks", // Checkbox for showing all tasks
                      style: GoogleFonts.expletusSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: isAllSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        isAllSelected = value ?? false; // Update the checkbox state
                      });
                      if (isAllSelected) {
                        context.read<TaskBloc>().add(FilterTasks(null)); // Show all tasks
                      } else {
                        context.read<TaskBloc>().add(FilterTasks(false)); // Show only pending tasks
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Show a dialog for adding or editing tasks
  void showTaskDialog(BuildContext context, Task? task) {
    TextEditingController titleController =
    TextEditingController(text: task?.title);
    TextEditingController descriptionController =
    TextEditingController(text: task?.description);
    bool isCompleted = task?.isCompleted ?? false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                task == null ? 'Add Task' : 'Edit Task', // Dialog title
                style: GoogleFonts.expletusSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[900],
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // TextField for task title
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Task',
                    ),
                  ),
                  // TextField for task description
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  // Switch for task completion status
                  SwitchListTile(
                    title: Text(
                      "Completed",
                      style: GoogleFonts.expletusSans(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: isCompleted,
                    onChanged: (value) {
                      setState(() {
                        isCompleted = value; // Update completion status
                      });
                    },
                  ),
                ],
              ),
              actions: [
                // Cancel button to close the dialog
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.expletusSans(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                // Save or update button for the task
                ElevatedButton(
                  onPressed: () {
                    final newTask = Task(
                      id: task?.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      isCompleted: isCompleted,
                    );
                    context.read<TaskBloc>().add(
                        task == null ? AddTask(newTask) : UpdateTask(newTask)); // Add or update task
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(
                    task == null ? 'Add' : 'Update',
                    style: GoogleFonts.expletusSans(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
