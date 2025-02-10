# To-Do App using BLoc and SQLite

A simple Flutter application that allows users to manage their tasks with CRUD (Create, Read, Update, Delete) operations. The app uses **BLoC** state management and **SQLite** for local storage.

## Features

- **Create a Task**: Add a task with a title and an optional description.
- **Read Tasks**: View all tasks in a list.
- **Update a Task**: Edit task details (title/description).
- **Delete a Task**: Remove a task from the list.
- **Filter Tasks**: Filter tasks by **completed** or **pending** status.

## Requirements

- **Flutter**: Ensure you have Flutter installed on your system. [Install Flutter](https://flutter.dev/docs/get-started/install).
- **BLoC**: For state management in the app.
- **SQLite**: For local storage of tasks.

## Installation

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/shasliya/Task_updation_with_bloc.git
   
2. Navigate to the project directory
   ```bash
   cd Task_updation_with_bloc
   
3. Install the dependencies
   ```bash
    flutter pub get
   
4. Run the app
   ```bash
   flutter run

## Project Structure

The project follows a **Model-View-Controller (MVC)** design pattern. Here's an overview of the key directories:

- **lib/**: Contains all the main Dart code for the app.
  - **bloc/**: Contains the BLoC files for managing state (events, states, and the BLoC class itself).
  - **model/**: Contains data models, such as the `Task` model.
  - **screens/**: Contains the UI screens where tasks can be added, updated, or displayed.
  - **repository/**: Handles SQLite database operations (e.g., storing, deleting, and updating tasks).
  - **main.dart**: The entry point of the app where the app is initialized and run.
 
## Functionality

- **Create a Task**: Add a task with a title and an optional description.
- **Read Tasks**: View tasks in a list.
- **Update a Task**: Edit task details like title and description.
- **Delete a Task**: Remove a task from the list.
- **Filter Tasks**: Filter tasks based on their **completed** or **pending** status.
- **SQLite Integration**: Data is stored locally using SQLite for persistent storage.
- **BLoC State Management**: The app uses the BLoC pattern to manage state and ensure a clean architecture.



