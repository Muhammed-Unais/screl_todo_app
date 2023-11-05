import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:screl_todo_app/features/add_task_view/view_model/add_task_view_model.dart';
import 'package:screl_todo_app/features/home/model/task_model.dart';
import 'package:provider/provider.dart';
import 'package:screl_todo_app/features/home/view/home_view.dart';
import 'package:screl_todo_app/features/home/view_model/home_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(TaskModelAdapter().typeId)) {
    Hive.registerAdapter(TaskModelAdapter());
  }

  await Hive.openBox<TaskModel>('task-model');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddTaskViewModel(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
