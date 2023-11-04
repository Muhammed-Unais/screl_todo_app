import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screl_todo_app/features/home/view_model/home_view_model.dart';

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

class AddTasks extends StatelessWidget {
  const AddTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Your Todo"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller:
                  context.watch<HomeViewModel>().taskTextEditingController,
              validator: (value) {
                if (value!.isEmpty || value.length <= 10) {
                  return "Enter atleast 10 words";
                }
                return null;
              },
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              minLines: 1,
              decoration: const InputDecoration(hintText: "Task"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
              ),
              onPressed: () async {
                var homeProvider = context.read<HomeViewModel>();
                if (formkey.currentState!.validate() &&
                    formkey.currentState != null) {
                  homeProvider.postTask(
                      homeProvider.taskTextEditingController.text, false);
                  homeProvider.taskTextEditingController.clear();
                }
              },
              child: const Text(
                "Create",
              ),
            )
          ],
        ),
      ),
    );
  }
}
