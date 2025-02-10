class Task {
  final int? id; // Task ID, optional (null if new task)
  final String title; // Task title (required)
  final String description; // Task description (required)
  final bool isCompleted; // Task completion status (default is false)

  // Constructor to create a new task
  Task(
      {this.id,
        required this.title,
        required this.description,
        this.isCompleted = false});

  // Convert the Task object to a map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Store the task ID (null if it's a new task)
      'title': title, // Store the title
      'description': description, // Store the description
      'isCompleted': isCompleted ? 1 : 0, // Store as 1 (completed) or 0 (pending)
    };
  }

  // Convert a map to a Task object (for database retrieval)
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'], // Get the task ID
      title: map['title'], // Get the title
      description: map['description'], // Get the description
      isCompleted: map['isCompleted'] == 1, // Convert 1 to true (completed), 0 to false (pending)
    );
  }
}
