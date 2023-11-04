import 'package:hive_flutter/hive_flutter.dart';
part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel {

  @HiveField(1)
  String task;
  @HiveField(2)
  bool status;

  TaskModel({required this.task, required this.status});
}
