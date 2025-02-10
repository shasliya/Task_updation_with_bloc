import 'package:sqflite/sqflite.dart';
import '../model/task.dart';

class DBHelper {
  // Open a connection to the database and create the tasks table
  static Future<Database> _database() async {
    return await openDatabase(
      'tasks.db', // Database name
      version: 1, // Version number of the database
      onCreate: (db, version) {
        // Create the tasks table with the necessary columns
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isCompleted INTEGER)",
        );
      },
    );
  }

  // Fetch all tasks from the database and return them as a list of Task objects
  static Future<List<Task>> getTasks() async {
    final db = await _database(); // Get the database instance
    final List<Map<String, dynamic>> maps = await db.query('tasks'); // Query all tasks from the database
    // Convert the list of maps to a list of Task objects
    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]); // Map each entry to a Task object
    });
  }

  // Insert a new task into the database, replacing it if it already exists
  static Future<void> insertTask(Task task) async {
    final db = await _database();
    await db.insert(
      'tasks',
      task.toMap(), // Map the task object to a map for insertion
      conflictAlgorithm: ConflictAlgorithm.replace, // Replace the existing task if it conflicts
    );
  }

  // Update an existing task in the database
  static Future<void> updateTask(Task task) async {
    final db = await _database();
    await db.update(
      'tasks',
      task.toMap(),
      where: "id = ?", // Specify which task to update based on its ID
      whereArgs: [task.id], // Provide the task ID as an argument
    );
  }

  // Delete a task from the database by its ID
  static Future<void> deleteTask(int id) async {
    final db = await _database();
    await db.delete(
      'tasks',
      where: "id = ?", // Specify which task to delete based on its ID
      whereArgs: [id], // Provide the task ID as an argument
    );
  }
}
