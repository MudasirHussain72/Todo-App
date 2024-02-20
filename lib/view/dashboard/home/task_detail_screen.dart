// ignore_for_file: must_be_immutable

import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/loading_widget.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String taskID, goalID;

  const TaskDetailsScreen(
      {super.key, required this.taskID, required this.goalID});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  void _updateTaskCompletionStatus(bool completed) async {
    try {
      // Reference to the Firestore task document to be updated
      DocumentReference taskDocumentReference = FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid.toString())
          .collection('goals')
          .doc(widget.goalID)
          .collection('tasks')
          .doc(widget.taskID);

      // Update Firestore document with completion status
      await taskDocumentReference.update({
        'isCompleted': completed,
      }).then((value) async {
        // Check if all tasks under the goal are completed
        QuerySnapshot tasksSnapshot = await FirebaseFirestore.instance
            .collection('User')
            .doc(SessionController().user.uid.toString())
            .collection('goals')
            .doc(widget.goalID)
            .collection('tasks')
            .get();

        bool allTasksCompleted = tasksSnapshot.docs.every(
            (doc) => doc.exists && (doc.data() as Map)['isCompleted'] == true);

        // If all tasks are completed, update the goal's isCompleted field
        if (allTasksCompleted) {
          DocumentReference goalDocumentReference = FirebaseFirestore.instance
              .collection('User')
              .doc(SessionController().user.uid.toString())
              .collection('goals')
              .doc(widget.goalID);

          await goalDocumentReference.update({
            'isCompleted': true,
          }).then((value) {
            var provider = Provider.of<HomeController>(context, listen: false);
            provider.fetchAndSetTasksCount();
          });

          print('Goal completion status updated successfully');
        } else {
          var provider = Provider.of<HomeController>(context, listen: false);
          provider.fetchAndSetTasksCount();
        }
      });

      // Print a message indicating successful update
      print('Task completion status updated successfully');
    } catch (error) {
      // Handle any errors that occur during the update process
      print('Failed to update task completion status: $error');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Task Details'),
        actions: [
          Consumer<HomeController>(
              builder: (context, value, child) => IconButton(
                    onPressed: () async {
                      try {
                        // Reference to the Firestore task document to be deleted
                        DocumentReference taskDocumentReference =
                            FirebaseFirestore.instance
                                .collection('User')
                                .doc(SessionController().user.uid.toString())
                                .collection('goals')
                                .doc(widget.goalID)
                                .collection('tasks')
                                .doc(widget.taskID);

                        // Reference to the Firestore tasks subcollection
                        CollectionReference tasksCollectionReference =
                            FirebaseFirestore.instance
                                .collection('User')
                                .doc(SessionController().user.uid.toString())
                                .collection('goals')
                                .doc(widget.goalID)
                                .collection('tasks');

                        // Query the tasks subcollection to get all documents
                        QuerySnapshot tasksSnapshot =
                            await tasksCollectionReference.get();

                        // Check if there's only one document in the tasks subcollection
                        if (tasksSnapshot.docs.length == 1) {
                          // If there's only one document, delete the entire goals document
                          await FirebaseFirestore.instance
                              .collection('User')
                              .doc(SessionController().user.uid.toString())
                              .collection('goals')
                              .doc(widget.goalID)
                              .delete();
                        } else {
                          // If there are multiple documents, delete only the specific task document
                          await taskDocumentReference.delete();
                        }

                        // Navigate back to the previous screen
                        Navigator.pop(context);
                      } catch (error) {
                        // Handle any errors that occur during the deletion process
                        print('Failed to delete document: $error');
                      } finally {
                        value.fetchAndSetTasksCount();
                      }
                    },
                    icon: const Icon(Icons.delete),
                  )),
          Consumer<HomeController>(
            builder: (context, value, child) => IconButton(
              padding: const EdgeInsets.only(right: 20, left: 10),
              onPressed: () {
                _showEditDialog();
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('User')
              .doc(SessionController().user.uid.toString())
              .collection('goals')
              .doc(widget.goalID)
              .collection('tasks')
              .doc(widget.taskID)
              .get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Center(child: Text("Document does not exist"));
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              TaskModel task = TaskModel.fromJson(data);
              // Set previous data in text fields
              _titleController.text = task.taskTitle ?? '';
              _descriptionController.text = task.taskDescription ?? '';
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width * 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _parseColor(task.taskColor!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        color: Colors.white,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          task.endDate.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors.whiteColor,
                                                  fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.goalName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: AppColors.whiteColor,
                                                fontSize: 22),
                                      ),
                                      Text(
                                        task.taskTitle.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: AppColors.whiteColor,
                                                fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                if (task.isCompleted!)
                                  Center(
                                    child: Text(
                                      'Task Completed ✅',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.whiteColor,
                                              fontSize: 22),
                                    ),
                                  ),
                                SizedBox(height: 20),
                                if (!task.isCompleted!)
                                  // Action slider
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: ActionSlider.standard(
                                      backgroundColor:
                                          _parseColor(task.taskColor!)
                                              .withOpacity(0.4),
                                      toggleColor: _parseColor(task.taskColor!)
                                          .withOpacity(0.3),
                                      rolling: true,
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                      loadingIcon: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        'Drag to mark done',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: AppColors.whiteColor,
                                                fontSize: 16),
                                      ),
                                      action: (controller) async {
                                        controller
                                            .loading(); //starts loading animation
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        controller.success();
                                        //starts success animation
                                        _updateTaskCompletionStatus(true);
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ), // end upcoming task container
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Info',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 18,
                                        color: AppColors.secondaryTextColor),
                              ),
                              Text(
                                task.endDate.toString(),
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: AppColors.primaryTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Goals progress
                      SizedBox(
                        width: size.width * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: size.width * 0.48,
                              child: Text(
                                'Task description',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        fontSize: 18,
                                        color: AppColors.secondaryTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: size.width * 0.9,
                        padding: const EdgeInsets.all(20),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Text(
                          task.taskDescription.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.primaryTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: LoadingWidget());
          },
        ),
      ),
    );
  }

  Color _parseColor(String colorHex) {
    // Remove any leading '#' if present in the hexadecimal color string
    colorHex = colorHex.replaceAll("#", "");

    // Pad the hexadecimal color string with zeros if it's not of length 6 (e.g., "RRGGBB")
    if (colorHex.length == 6) {
      colorHex = "FF" + colorHex; // Adding the alpha channel (FF) if missing
    } else if (colorHex.length != 8) {
      throw ArgumentError("Invalid hexadecimal color code: $colorHex");
    }

    // Parse the hexadecimal color code and return a Color object
    return Color(int.parse(colorHex, radix: 16));
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Task Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration:
                    const InputDecoration(labelText: 'Task Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Get updated values from text fields
                String newTitle = _titleController.text;
                String newDescription = _descriptionController.text;

                // Reference to the Firestore document to be updated
                DocumentReference taskDocumentReference = FirebaseFirestore
                    .instance
                    .collection('User')
                    .doc(SessionController().user.uid.toString())
                    .collection('goals')
                    .doc(widget.goalID)
                    .collection('tasks')
                    .doc(widget.taskID);

                // Update Firestore document with new values
                taskDocumentReference.update({
                  'taskTitle': newTitle,
                  'taskDescription': newDescription,
                }).then((_) {
                  // Update successful
                  print('Document updated successfully');
                  // Optionally, you can show a success message
                }).catchError((error) {
                  // Handle any errors that occur during the update process
                  print('Failed to update document: $error');
                  // Optionally, you can show an error message
                });

                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
