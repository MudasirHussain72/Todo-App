// ignore_for_file: must_be_immutable

import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
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
                      // try {
                      //   // Check if the task to be deleted is the last task in its goal
                      //   bool isLastTask = false;
                      //   for (var goal in value.goalsList) {
                      //     if (goal.taskList != null &&
                      //         goal.taskList!.length == 1) {
                      //       if (goal.taskList!.first.taskId ==
                      //           widget.taskDetail!.taskId) {
                      //         isLastTask = true;
                      //         break;
                      //       }
                      //     }
                      //   }

                      //   // Remove the task from the goal list using its ID
                      //   for (var goal in value.goalsList) {
                      //     if (goal.taskList != null) {
                      //       goal.taskList!.removeWhere((task) =>
                      //           task.taskId == widget.taskDetail!.taskId);
                      //     }
                      //   }

                      //   // Delete the task from Firestore
                      //   await FirebaseFirestore.instance
                      //       .collection('User')
                      //       .doc(SessionController().user.uid)
                      //       .collection('goals')
                      //       .doc(widget.taskDetail!.goalId)
                      //       .update({
                      //     'taskList': FieldValue.arrayRemove(
                      //         [widget.taskDetail!.toJson()])
                      //   }).then((value) => Navigator.pop(context));

                      //   // Refresh the data in HomeController
                      //   await value.fetchAndSetTasksCount();

                      //   // If it's the last task in the goal, delete the goal document
                      //   if (isLastTask) {
                      //     await FirebaseFirestore.instance
                      //         .collection('User')
                      //         .doc(SessionController().user.uid)
                      //         .collection('goals')
                      //         .doc(widget.taskDetail!.goalId)
                      //         .delete()
                      //         .then((value) => Navigator.pop(context));
                      //     // Refresh the data in HomeController again to reflect the deletion of the goal
                      //     await value.fetchAndSetTasksCount();
                      //   }
                      // } catch (error) {
                      //   print("Failed to delete task: $error");
                      // }
                    },
                    icon: const Icon(Icons.delete),
                  )),
          Consumer<HomeController>(
            builder: (context, value, child) => IconButton(
              padding: const EdgeInsets.only(right: 20, left: 10),
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child:
            // StreamBuilder(
            // stream: FirebaseFirestore.instance
            //     .collection('User')
            //     .doc(SessionController().user.uid.toString())
            //     .collection('goals')
            //     .doc(widget.goalID)
            //     .collection('tasks')
            //     .snapshots(),
            //   builder: (context, snapshot) {
            //     var data=snapshot.data.docs
            //     return Text('data');
            //   },
            // ),
            FutureBuilder<DocumentSnapshot>(
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
              return const Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              TaskModel task = TaskModel.fromJson(data);
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        width: size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: _parseColor(task.taskColor!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  // Time and edit row
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.timer_outlined,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            task.endDate.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.edit_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Task name row
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task.goalName!,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              task.taskTitle.toString(),
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        // const Icon(
                                        //   Icons.remove_red_eye_rounded,
                                        //   color: Colors.white,
                                        //   size: 50,
                                        // ),
                                        // const SizedBox(width: 20),
                                        // const Icon(
                                        //   Icons.remove_red_eye_rounded,
                                        //   color: Colors.white,
                                        //   size: 50,
                                        // ),
                                      ],
                                    ),
                                  ),

                                  // Action slider
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: ActionSlider.standard(
                                      backgroundColor:
                                          // _parseColor(widget.taskDetail!.taskColor!)
                                          //     .withOpacity(0.4),
                                          _parseColor(task.taskColor!)
                                              .withOpacity(0.4),
                                      toggleColor:
                                          // _parseColor(widget.taskDetail!.taskColor!)
                                          //     .withOpacity(0.3),
                                          _parseColor(task.taskColor!)
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
                                      child: const Text(
                                        'Drag to mark done',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      action: (controller) async {
                                        controller
                                            .loading(); //starts loading animation
                                        await Future.delayed(
                                            const Duration(seconds: 3));
                                        controller
                                            .success(); //starts success animation
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ), // end upcoming task container
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 5),
                              child: Text(
                                'Info',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 5),
                              child: Text(
                                task.endDate.toString(),
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 20),
                              child: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'https://www.youtube.com/watch?v=c2JNZ8nxCCU',
                                  // maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              child: const Text(
                                'Goal',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Goals progress horizontal listview
                      Container(
                        width: size.width * 0.9,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 12, bottom: 12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          task.goalName.toString(),
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(height: 5),
                                        // Text(
                                        //   '${widget.goalTasksCompletedCount}/${widget.goalTasksTotalCount}',
                                        //   style: const TextStyle(
                                        //       fontSize: 20,
                                        //       fontWeight: FontWeight.w600,
                                        //       color: Colors.grey),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 10),
                                  //   child: CircularPercentIndicator(
                                  //     radius: 40.0,
                                  //     lineWidth: 8.0,
                                  //     percent: widget.goalTasksCompletedCount /
                                  //         widget.goalTasksTotalCount,
                                  //     center: Text(
                                  //       '${((widget.goalTasksCompletedCount / widget.goalTasksTotalCount) * 100).toStringAsFixed(0)}%',
                                  //       style: const TextStyle(fontSize: 12),
                                  //     ),
                                  //     progressColor:
                                  //         _parseColor(task.taskColor!),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey)),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 20,
                                        bottom: 5),
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 20, right: 20, bottom: 20),
                                  //   child: Text(
                                  //     widget.taskDetail!.goalDescription.toString(),
                                  //     style: const TextStyle(
                                  //       fontSize: 20,
                                  //       color: Colors.grey,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
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
}
