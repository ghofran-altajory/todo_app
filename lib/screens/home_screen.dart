import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();

  // List for completed tasks (unchanged)
  List<TaskModel> tasks = [];

  // New list for waiting tasks
  List<TaskModel> waitingTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.task),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add New Task"),
                content: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Title is Rquired";
                          }
                          if (value.length < 3) {
                            return "Title Must bet more than 2 chars";
                          }
                          return null;
                        },
                        controller: titleController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: "Task Title here"),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "SubTitle is Rquired";
                          }
                          if (value.length < 3) {
                            return "SubTitle Must bet more than 2 chars";
                          }
                          return null;
                        },
                        controller: subTitleController,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)),
                            hintText: "Task Subtitle here"),
                      ),
                      const SizedBox(
                        height: 5,
                      ), // ... form fields for title and subtitle (unchanged)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  // ignore: deprecated_member_use
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                // Create a new TaskModel object with validated data
                               final task = TaskModel(
    title: titleController.text,
    subTitle: subTitleController.text,
    isCompleted: false,
    createdAt: DateTime.now(),
    subTutle: '' // Duplicate subTitle property
);


                                // Add the task to the waitingTasks list
                                waitingTasks.add(task);

                                titleController.clear();
                                subTitleController.clear();
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              "Add",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              titleController.clear();
                              subTitleController.clear();
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                labelColor: Colors.blue,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: "Completed"),
                  Tab(text: "Waiting"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Image.asset("assets/ss.png")),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: waitingTasks.length, // Use waitingTasks list
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(waitingTasks[index].title.toString()),
                          subtitle:
                              Text(waitingTasks[index].createdAt.toString()),
                          trailing: Checkbox(
                            value: waitingTasks[index].isCompleted,
                            onChanged:
                                (status) {}, // Implement logic for marking completed (optional)
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
