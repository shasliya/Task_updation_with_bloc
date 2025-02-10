import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowithblocandsql/screen/home.dart'; // Import home screen for the app
import 'bloc/task_bloc.dart'; // Import TaskBloc for state management
import 'bloc/task_event.dart'; // Import TaskEvent for triggering events

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // BlocProvider is used to provide the TaskBloc to the widget tree
      create: (context) => TaskBloc()..add(LoadTasks()), // Initialize TaskBloc and trigger LoadTasks event
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task_updation_app', // Set the app title
        theme: ThemeData(
          primaryColor: Colors.teal, // Primary color for the app (app bar, buttons, etc.)
          scaffoldBackgroundColor: Colors.white, // Set background color of the app
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.black), // Text color for the body text
          ),
        ),
        home: HomeScreen(), // Set the home screen of the app
      ),
    );
  }
}
