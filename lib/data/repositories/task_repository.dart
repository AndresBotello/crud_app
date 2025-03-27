import 'package:crud_app/data/services/task_api_services.dart';

import '../../domain/models/task.dart';

class TaskRepository {
  final TaskApiService _apiService = TaskApiService();

  Future<List<Task>> getAllTasks() async {
    return await _apiService.getAllTasks();
  }

  Future<Task?> getTaskById(String id) async {
    try {
      return await _apiService.getTaskById(id);
    } catch (e) {
      return null;
    }
  }

  Future<void> addTask(Task task) async {
    await _apiService.createTask(task);
  }

  Future<void> updateTask(Task updatedTask) async {
    await _apiService.updateTask(updatedTask);
  }

  Future<void> deleteTask(String id) async {
    await _apiService.deleteTask(id);
  }
}
