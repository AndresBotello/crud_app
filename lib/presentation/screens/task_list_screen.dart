import 'package:crud_app/domain/models/task.dart';
import 'package:crud_app/presentation/controllers/task_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_edit_screen.dart';

class TaskListScreen extends StatelessWidget {
  final TaskController _taskController = Get.put(TaskController());

  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Tareas'), centerTitle: true),
      body: Obx(() {
        if (_taskController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_taskController.tasks.isEmpty) {
          return const Center(child: Text('No hay tareas'));
        }

        return ListView.builder(
          itemCount: _taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = _taskController.tasks[index];
            return TaskListItem(
              task: task,
              onTap: () => _navigateToEditScreen(task),
              onStatusChanged:
                  (newStatus) => _updateTaskStatus(task, newStatus),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateScreen,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateScreen() {
    Get.to(() => TaskEditScreen());
  }

  void _navigateToEditScreen(Task task) {
    Get.to(() => TaskEditScreen(task: task));
  }

  void _updateTaskStatus(Task task, TaskStatus newStatus) {
    _taskController.updateTaskStatus(task, newStatus);
  }
}

class TaskListItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final Function(TaskStatus) onStatusChanged;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onTap,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(task.nombre),
        subtitle: Text(task.detalle),
        trailing: DropdownButton<TaskStatus>(
          value: task.estado,
          onChanged: (TaskStatus? newStatus) {
            if (newStatus != null) {
              onStatusChanged(newStatus);
            }
          },
          items:
              TaskStatus.values.map<DropdownMenuItem<TaskStatus>>((
                TaskStatus status,
              ) {
                return DropdownMenuItem<TaskStatus>(
                  value: status,
                  child: Text(_getStatusText(status)),
                );
              }).toList(),
        ),
        onTap: onTap,
      ),
    );
  }

  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pendiente:
        return 'Pendiente';
      case TaskStatus.enProgreso:
        return 'En Progreso';
      case TaskStatus.completada:
        return 'Completada';
    }
  }
}
