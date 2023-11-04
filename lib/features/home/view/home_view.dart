import 'package:flutter/material.dart';

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
        onPressed: () {},
        label: const Text(
          "Add Your Task",
        ),
      ),
      body: ListView.separated(
        itemCount: 6,
        padding: const EdgeInsets.all(10),
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.white38,
            thickness: 2,
          );
        },
        itemBuilder: (context, index) {
          return Card(
            elevation: 10,
            child: ListTile(
              leading: CircleAvatar(
                child: Text("${index + 1}"),
              ),
              title: const Text("new"),
              subtitle: const Text("one"),
              trailing: PopupMenuButton(
                onSelected: (value) {},
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "Delete",
                      child: Text(
                        "Delete",
                      ),
                    ),
                    const PopupMenuItem(
                      value: "Edit",
                      child: Text(
                        "Edit",
                      ),
                    ),
                  ];
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
