import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:screl_todo_app/data/local_data_service/local_data_service.dart';
import 'package:screl_todo_app/data/response/local_sevice_response.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';
import 'package:screl_todo_app/features/home/repository/get_tasks_repository.dart';
import 'package:screl_todo_app/features/home/repository/post_task_repository.dart';

class HomeViewModel with ChangeNotifier {
  final _myPostTaskRepo = PostTaskRepository(LocalDataService());
  final _myGetAllTaskRepo =
      GetTasksRepository(baseLocalDataService: LocalDataService());

  TextEditingController taskTextEditingController = TextEditingController();

  LocalServiceResponse<List<TaskModel>> getAllTaskResponse =
      LocalServiceResponse.loading();

  bool postIsLoading = false;

  void setPostTasks(bool isLoading) {
    postIsLoading = isLoading;
    notifyListeners();
  }

  void setGetAllTasks(
      LocalServiceResponse<List<TaskModel>> localServiceResponse) {
    getAllTaskResponse = localServiceResponse;
    notifyListeners();
  }

  Future<void> postTask(String task, bool status) async {
    setPostTasks(true);
    final taskModel = TaskModel(task: task, status: status);
    _myPostTaskRepo.postTask(taskModel).then((value) {
      setPostTasks(false);

      log("success");
    }).onError(
      (error, stackTrace) {
        setPostTasks(false);
        log(error.toString());
      },
    );
  }

  void getAllTask() async {
    setGetAllTasks(LocalServiceResponse.loading());
    await _myGetAllTaskRepo.getAllTaskRepository().then((value) {
      setGetAllTasks(LocalServiceResponse.completed(value));

      log(value.toString());
      log("success");
    }).onError(
      (error, stackTrace) {
        setGetAllTasks(LocalServiceResponse.error(error.toString()));
        log(error.toString());
      },
    );
  }

  HomeViewModel() {
    getAllTask();
  }
}
