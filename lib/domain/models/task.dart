class Task {
  String? id;
  String nombre;
  String detalle;
  TaskStatus estado;

  Task({
    this.id,
    required this.nombre,
    required this.detalle,
    this.estado = TaskStatus.pendiente,
  }) {
    id ??= DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Método para clonar la tarea
  Task copyWith({
    String? id,
    String? nombre,
    String? detalle,
    TaskStatus? estado,
  }) {
    return Task(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      detalle: detalle ?? this.detalle,
      estado: estado ?? this.estado,
    );
  }
}

enum TaskStatus { pendiente, enProgreso, completada }

// Extension para conversión de enum a string
extension TaskStatusExtension on TaskStatus {
  String toShortString() {
    return toString().split('.').last;
  }

  static TaskStatus fromString(String status) {
    return TaskStatus.values.firstWhere(
      (e) => e.toShortString() == status,
      orElse: () => TaskStatus.pendiente,
    );
  }
}
