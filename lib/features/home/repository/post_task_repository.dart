import 'package:screl_todo_app/data/local_data_service/base_local_service.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';

class PostTaskRepository {
  final BaseLocalDataService baseLocalDataService;

  PostTaskRepository(this.baseLocalDataService);

  Future<void> postTask(TaskModel taskModel) async {
    try {
      baseLocalDataService.postData(taskModel);
    } catch (e) {
      rethrow;
    }
  }
}
