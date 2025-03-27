import 'package:crud_app/data/repositories/task_repository.dart';
import 'package:crud_app/domain/models/task.dart';

class TaskUseCases {
  final TaskRepository _repository;

  TaskUseCases(this._repository);

  List<Task> getAllTasks() {
    return _repository.getAllTasks();
  }

  Task? getTaskById(String id) {
    return _repository.getTaskById(id);
  }

  Task createTask(String nombre, String detalle) {
    final task = Task(
      nombre: nombre,
      detalle: detalle,
      estado: TaskStatus.pendiente,
    );
    _repository.addTask(task);
    return task;
  }

  void updateTaskStatus(Task task, TaskStatus newStatus) {
    final updatedTask = task.copyWith(estado: newStatus);
    _repository.updateTask(updatedTask);
  }

  void updateTaskDetails(Task task, String newNombre, String newDetalle) {
    final updatedTask = task.copyWith(nombre: newNombre, detalle: newDetalle);
    _repository.updateTask(updatedTask);
  }

  void deleteTask(String id) {
    _repository.deleteTask(id);
  }
}
