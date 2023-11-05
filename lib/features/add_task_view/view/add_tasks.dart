import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screl_todo_app/features/add_task_view/view_model/add_task_view_model.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class AddTasks extends StatelessWidget {
  const AddTasks({super.key, this.isCreate = true, this.taskModel, this.index});

  final bool isCreate;

  final TaskModel? taskModel;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            var addTaskProvider = context.read<AddTaskViewModel>();
            addTaskProvider.taskTextEditingController.clear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        title: Text(isCreate ? " Create Your Task" : "Update Your Task"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller:
                  context.watch<AddTaskViewModel>().taskTextEditingController,
              validator: (value) {
                if (value!.isEmpty || value.length <= 10) {
                  return "Enter atleast 10 words";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              minLines: 1,
              decoration: const InputDecoration(
                hintText: "Task",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
              ),
              onPressed: () async {
                var addTaskProvider = context.read<AddTaskViewModel>();
                if (formkey.currentState!.validate() &&
                    formkey.currentState != null) {
                  if (isCreate) {
                    addTaskProvider.postTask(
                      addTaskProvider.taskTextEditingController.text,
                      false,
                      context,
                    );
                  } else {
                    addTaskProvider.editTask(
                      addTaskProvider.taskTextEditingController.text,
                      index!,
                      taskModel!,
                      context,
                    );
                  }
                }
              },
              child: Text(
                isCreate ? "Create" : "Update",
              ),
            )
          ],
        ),
      ),
    );
  }
}
