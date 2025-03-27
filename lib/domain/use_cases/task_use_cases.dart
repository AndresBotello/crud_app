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

  Future<Task> createTask(
    String nombre,
    String detalle,
    TaskStatus estado,
  ) async {
    final task = Task(nombre: nombre, detalle: detalle, estado: estado);
    await _repository.addTask(task);
    return task;
  }

  Future<void> updateTask(
    String id,
    String nombre,
    String detalle,
    TaskStatus estado,
  ) async {
    final task = Task(id: id, nombre: nombre, detalle: detalle, estado: estado);
    await _repository.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
  }
}
