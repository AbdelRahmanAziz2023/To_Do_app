import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    print('task insert');
    return DBHelper.insert(task);
  }

  void deleteTask(Task task) async {
    print('task delete');
    await DBHelper.delete(task);
    getTask();
  }

  void markAsCompletedTask(Task task) async {
    print('task mark');
    await DBHelper.upDate(task);
    getTask();
  }

  Future<void> getTask() async {
    print('task load');
    final List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }
}
