import '../../data/repositories/task_repository.dart';
import '../models/task.dart';

class TaskUseCases {
  final TaskRepository _repository;

  TaskUseCases(this._repository);

  Future<List<Task>> getAllTasks() {
    return _repository.getAllTasks();
  }

  Future<Task?> getTaskById(String id) {
    return _repository.getTaskById(id);
  }

  Future<Task> createTask(String nombre, String detalle) async {
    final task = Task(
      nombre: nombre,
      detalle: detalle,
      estado: TaskStatus.pendiente,
    );
    await _repository.addTask(task);
    return task;
  }

  Future<void> updateTaskStatus(Task task, TaskStatus newStatus) async {
    final updatedTask = task.copyWith(estado: newStatus);
    await _repository.updateTask(updatedTask);
  }

  Future<void> updateTaskDetails(
    Task task,
    String newNombre,
    String newDetalle,
  ) async {
    final updatedTask = task.copyWith(nombre: newNombre, detalle: newDetalle);
    await _repository.updateTask(updatedTask);
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
  }
}
