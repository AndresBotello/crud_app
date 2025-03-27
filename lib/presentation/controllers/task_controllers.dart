import 'package:get/get.dart';
import '../../domain/models/task.dart';
import '../../domain/use_cases/task_use_cases.dart';
import '../../data/repositories/task_repository.dart';

class TaskController extends GetxController {
  final TaskUseCases _taskUseCases = TaskUseCases(TaskRepository());

  RxList<Task> tasks = <Task>[].obs;

  get isLoading => null;

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    tasks.value = _taskUseCases.getAllTasks();
  }

  void createTask(String nombre, String detalle) {
    final task = _taskUseCases.createTask(nombre, detalle);
    fetchTasks();
  }

  void updateTaskStatus(Task task, TaskStatus newStatus) {
    _taskUseCases.updateTaskStatus(task, newStatus);
    fetchTasks();
  }

  void updateTaskDetails(Task task, String newNombre, String newDetalle) {
    _taskUseCases.updateTaskDetails(task, newNombre, newDetalle);
    fetchTasks();
  }

  void deleteTask(String id) {
    _taskUseCases.deleteTask(id);
    fetchTasks();
  }
}
