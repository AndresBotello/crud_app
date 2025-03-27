import 'package:crud_app/domain/models/task.dart';

class TaskRepository {
  final List<Task> _tasks = [];

  List<Task> getAllTasks() {
    return List.from(_tasks);
  }

  Task? getTaskById(String id) {
    try {
      return _tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
  }
}
