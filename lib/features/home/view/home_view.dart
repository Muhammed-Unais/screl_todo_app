import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screl_todo_app/data/response/enums.dart';
import 'package:screl_todo_app/features/add_task_view/view/add_tasks.dart';
import 'package:screl_todo_app/features/home/view/components/todo_list_tale.dart';
import 'package:screl_todo_app/features/home/view_model/home_view_model.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddTasks();
              },
            ),
          );
        },
        label: const Text(
          "Add Your Task",
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, homeProvider, _) {
          switch (homeProvider.getAllTaskResponse.status) {
            case Status.loading:
              return const Center(child: CircularProgressIndicator());
            case Status.completed:
              var data = homeProvider.getAllTaskResponse.data;

              if (data!.isEmpty) {
                return const Center(
                  child: Text("No data"),
                );
              }
              return ListView.separated(
                itemCount: data.length,
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.white38,
                    thickness: 2,
                  );
                },
                itemBuilder: (context, index) {
                  var task = data[index];
                  return TodoListTile(
                    task: task,
                    index: index,
                  );
                },
              );
            case Status.error:
              return const Text("Error");

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}


