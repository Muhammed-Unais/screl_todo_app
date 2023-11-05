import 'package:screl_todo_app/data/local_data_service/base_local_service.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';

class EditTaskRepository {
  final BaseLocalDataService baseLocalDataService;

  EditTaskRepository(this.baseLocalDataService);

  Future<void> editTask(int index, TaskModel taskModel) async {
    try {
      baseLocalDataService.putData(index, taskModel);
    } catch (e) {
      rethrow;
    }
  }
}
