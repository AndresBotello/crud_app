import 'package:get/get.dart';
import '../../domain/models/task.dart';
import '../../domain/use_cases/task_use_cases.dart';
import '../../data/repositories/task_repository.dart';

class TaskController extends GetxController {
  final TaskUseCases _taskUseCases = TaskUseCases(TaskRepository());

  RxList<Task> tasks = <Task>[].obs;
  RxBool isLoading = false.obs;
  Rx<String?> error = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    isLoading.value = true;
    error.value = null;
    try {
      tasks.value = await _taskUseCases.getAllTasks();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'No se pudieron cargar las tareas');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createTask(
    String nombre,
    String detalle,
    TaskStatus estado,
  ) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _taskUseCases.createTask(nombre, detalle, estado);
      await fetchTasks();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'No se pudo crear la tarea');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTask(
    String id,
    String nombre,
    String detalle,
    TaskStatus estado,
  ) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _taskUseCases.updateTask(id, nombre, detalle, estado);
      await fetchTasks();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'No se pudo actualizar la tarea');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateTaskStatus(Task task, TaskStatus newStatus) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _taskUseCases.updateTask(
        task.id!,
        task.nombre,
        task.detalle,
        newStatus,
      );
      await fetchTasks();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'No se pudo actualizar el estado de la tarea');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask(String id) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _taskUseCases.deleteTask(id);
      await fetchTasks();
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'No se pudo eliminar la tarea');
    } finally {
      isLoading.value = false;
    }
  }
}
