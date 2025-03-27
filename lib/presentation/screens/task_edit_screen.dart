import 'package:crud_app/presentation/controllers/task_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/models/task.dart';

class TaskEditScreen extends StatefulWidget {
  final Task? task;

  const TaskEditScreen({Key? key, this.task}) : super(key: key);

  @override
  _TaskEditScreenState createState() => _TaskEditScreenState();
}

class _TaskEditScreenState extends State<TaskEditScreen> {
  final TaskController _taskController = Get.find();

  late TextEditingController _nombreController;
  late TextEditingController _detalleController;
  late TaskStatus _selectedStatus;

  @override
  void initState() {
    super.initState();
    // Inicializar controladores
    _nombreController = TextEditingController(text: widget.task?.nombre ?? '');
    _detalleController = TextEditingController(
      text: widget.task?.detalle ?? '',
    );

    // Establecer estado inicial
    _selectedStatus = widget.task?.estado ?? TaskStatus.pendiente;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _detalleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Crear Tarea' : 'Editar Tarea'),
        actions:
            widget.task != null
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
        child: ListView(
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
            // Selector de estado
            DropdownButtonFormField<TaskStatus>(
              decoration: const InputDecoration(
                labelText: 'Estado de la Tarea',
                border: OutlineInputBorder(),
              ),
              value: _selectedStatus,
              onChanged: (TaskStatus? newStatus) {
                if (newStatus != null) {
                  setState(() {
                    _selectedStatus = newStatus;
                  });
                }
              },
              items:
                  TaskStatus.values.map((TaskStatus status) {
                    return DropdownMenuItem<TaskStatus>(
                      value: status,
                      child: Text(_getStatusText(status)),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text(widget.task == null ? 'Crear' : 'Actualizar'),
            ),
          ],
        ),
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

  void _saveTask() async {
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

    try {
      if (widget.task == null) {
        // Crear nueva tarea
        await _taskController.createTask(nombre, detalle, _selectedStatus);
      } else {
        // Actualizar tarea existente
        await _taskController.updateTask(
          widget.task!.id!,
          nombre,
          detalle,
          _selectedStatus,
        );
      }

      // Volver a la pantalla anterior
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudo guardar la tarea: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _deleteTask() async {
    if (widget.task != null) {
      try {
        await _taskController.deleteTask(widget.task!.id!);
        Get.back(); // Volver a la pantalla anterior
      } catch (e) {
        Get.snackbar(
          'Error',
          'No se pudo eliminar la tarea: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
