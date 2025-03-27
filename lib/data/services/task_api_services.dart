import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/models/task.dart';

class TaskApiService {
  final String baseUrl = 'https://nk0blh78-8000.use2.devtunnels.ms/docs';

  Future<List<Task>> getAllTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Task> tasks =
            body
                .map(
                  (dynamic item) => Task(
                    id: item['id'].toString(),
                    nombre: item['nombre'],
                    detalle: item['detalle'],
                    estado: _parseStatus(item['estado']),
                  ),
                )
                .toList();
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<Task> getTaskById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks/$id'));

      if (response.statusCode == 200) {
        var item = json.decode(response.body);
        return Task(
          id: item['id'].toString(),
          nombre: item['nombre'],
          detalle: item['detalle'],
          estado: _parseStatus(item['estado']),
        );
      } else {
        throw Exception('Failed to load task');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<Task> createTask(Task task) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': task.nombre,
          'detalle': task.detalle,
          'estado': task.estado.toShortString(),
        }),
      );

      if (response.statusCode == 201) {
        var item = json.decode(response.body);
        return Task(
          id: item['id'].toString(),
          nombre: item['nombre'],
          detalle: item['detalle'],
          estado: _parseStatus(item['estado']),
        );
      } else {
        throw Exception('Failed to create task');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<Task> updateTask(Task task) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/tasks/${task.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': task.nombre,
          'detalle': task.detalle,
          'estado': task.estado.toShortString(),
        }),
      );

      if (response.statusCode == 200) {
        var item = json.decode(response.body);
        return Task(
          id: item['id'].toString(),
          nombre: item['nombre'],
          detalle: item['detalle'],
          estado: _parseStatus(item['estado']),
        );
      } else {
        throw Exception('Failed to update task');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));

      if (response.statusCode != 204) {
        throw Exception('Failed to delete task');
      }
    } catch (e) {
      throw Exception('Error connecting to the server: $e');
    }
  }

  // Helper method to parse status
  TaskStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'pendiente':
        return TaskStatus.pendiente;
      case 'en progreso':
        return TaskStatus.enProgreso;
      case 'completada':
        return TaskStatus.completada;
      default:
        return TaskStatus.pendiente;
    }
  }
}
