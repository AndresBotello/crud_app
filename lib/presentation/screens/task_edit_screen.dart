import 'package:crud_app/domain/models/task.dart';
import 'package:crud_app/presentation/controllers/task_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskEditScreen extends StatelessWidget {
  final Task? task;
  final TaskController _taskController = Get.find();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _detalleController = TextEditingController();

  TaskEditScreen({super.key, this.task}) {
    if (task != null) {
      _nombreController.text = task!.nombre;
      _detalleController.text = task!.detalle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'Crear Tarea' : 'Editar Tarea'),
        actions:
            task != null
                ? [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _deleteTask,
                  ),
                ]
                : [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre de la Tarea',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _detalleController,
              decoration: const InputDecoration(
                labelText: 'Detalles',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(task == null ? 'Crear' : 'Actualizar'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTask() {
    final nombre = _nombreController.text.trim();
    final detalle = _detalleController.text.trim();

    if (nombre.isEmpty || detalle.isEmpty) {
      Get.snackbar(
        'Error',
        'Por favor complete todos los campos',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (task == null) {
      _taskController.createTask(nombre, detalle);
    } else {
      _taskController.updateTaskDetails(task!, nombre, detalle);
    }

    Get.back(); // Return to previous screen
  }

  void _deleteTask() {
    if (task != null) {
      _taskController.deleteTask(task!.id!);
      Get.back(); // Return to previous screen
    }
  }
}
