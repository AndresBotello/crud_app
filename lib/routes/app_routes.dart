import 'package:crud_app/presentation/screens/task_edit_screen.dart';
import 'package:crud_app/presentation/screens/task_list_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String taskList = '/';
  static const String taskEdit = '/edit';

  static final routes = [
    GetPage(name: taskList, page: () => TaskListScreen()),
    GetPage(name: taskEdit, page: () => TaskEditScreen()),
  ];
}
