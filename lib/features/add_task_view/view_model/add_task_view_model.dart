import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screl_todo_app/data/local_data_service/local_data_service.dart';
import 'package:screl_todo_app/features/add_task_view/repository/edit_task_repository.dart';
import 'package:screl_todo_app/features/add_task_view/repository/post_task_repository.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';
import 'package:screl_todo_app/features/home/view_model/home_view_model.dart';

class AddTaskViewModel with ChangeNotifier {
  final _myPostTaskRepo = PostTaskRepository(LocalDataService());

  final _myEditTaskRepo = EditTaskRepository(LocalDataService());

  TextEditingController taskTextEditingController = TextEditingController();

  bool postIsLoading = false;


  void setPostTasks(bool isLoading) {
    postIsLoading = isLoading;
    notifyListeners();
  }

  Future<void> postTask(String task, bool status, BuildContext context) async {
    setPostTasks(true);
    final taskModel = TaskModel(task: task, status: status);
    _myPostTaskRepo.postTask(taskModel).then((value) {
      context.read<HomeViewModel>().getAllTask();
      setPostTasks(false);
      taskTextEditingController.clear();
    }).onError(
      (error, stackTrace) {
        setPostTasks(false);
      },
    );
  }

  Future<void> editTask(String task, int index,TaskModel taskModel, BuildContext context) async {
    
    final newTaskModel = taskModel.copyWith(task: task);
    _myEditTaskRepo.editTask(index,newTaskModel).then((value) {
      context.read<HomeViewModel>().getAllTask();
      
      taskTextEditingController.clear();
    }).onError(
      (error, stackTrace) {
        
      },
    );
  }
}
