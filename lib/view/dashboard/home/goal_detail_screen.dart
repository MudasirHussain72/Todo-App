import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/loading_widget.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/dashboard/dashboard_view.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';
import 'package:todo_app/view_model/controller/goal_detail/goal_detail_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

// ignore: must_be_immutable
class GoalsDetailScreen extends StatefulWidget {
  GoalsModel? goalsData;
  GoalsDetailScreen({super.key, this.goalsData});

  @override
  State<GoalsDetailScreen> createState() => _GoalsDetailScreenState();
}

class _GoalsDetailScreenState extends State<GoalsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    setState(() {});
    return Scaffold(
        appBar: AppBar(
          title: const Text('Goal Details'),
          actions: [
            Consumer<EditGoaController>(
              builder: (context, value, child) => IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('User')
                      .doc(SessionController().user.uid.toString())
                      .collection('goals')
                      .doc(widget.goalsData!.goalId)
                      .delete()
                      .then((value) {
                    Utils.flushBarDoneMessage(
                        'Goal deletion succesfull', context, 2);
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: DashboardView(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  });
                },
                icon: Icon(Icons.delete),
              ),
            ),
            Consumer<EditGoaController>(
              builder: (context, value, child) => IconButton(
                padding: EdgeInsets.only(right: 20, left: 10),
                onPressed: () {
                  value.editGoalDetailDialog(
                      context, widget.goalsData!.goalId!);
                },
                icon: Icon(Icons.edit),
              ),
            )
          ],
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('User')
                .doc(SessionController().user.uid.toString())
                .collection('goals')
                .doc(widget.goalsData!.goalId!)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                GoalsModel goalsModel = GoalsModel.fromJson(data);
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          SizedBox(
                            width: size.width * 0.9,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(int.parse(
                                          '0xff${goalsModel.goalColor}'))
                                      .withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          goalsModel.goalTitle.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: AppColors
                                                      .primaryTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 0),
                                    child: Text(
                                      goalsModel.isCompleted == true
                                          ? 'Completed'
                                          : 'Not Completed',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    child: LinearPercentIndicator(
                                      animation: true,
                                      lineHeight: 20.0,
                                      animationDuration: 2000,
                                      percent: double.parse(goalsModel
                                              .percentage
                                              .toString()) /
                                          100,
                                      backgroundColor: Colors.grey[200]!,
                                      curve: Curves.easeInOut,
                                      barRadius: const Radius.circular(20),
                                      progressColor: Color(int.parse(
                                          '0xff${goalsModel.goalColor}')),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 5),
                                  child: Text(
                                    'Description',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            fontSize: 18,
                                            color:
                                                AppColors.secondaryTextColor),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20),
                                  child: Text(
                                    goalsModel.goalDescription.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                            color: AppColors.primaryTextColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Tasks',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 18,
                                    color: AppColors.secondaryTextColor),
                          ),
                          SizedBox(
                            width: size.width * 0.9,
                            child: FutureBuilder<QuerySnapshot>(
                                future: FirebaseFirestore.instance
                                    .collection('User')
                                    .doc(
                                        SessionController().user.uid.toString())
                                    .collection('goals')
                                    .doc(widget.goalsData!.goalId!)
                                    .collection('tasks')
                                    .where('goalId',
                                        isEqualTo: widget.goalsData!.goalId!)
                                    .get(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text("Something went wrong");
                                  }

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    List<dynamic> data = snapshot.data!.docs;

                                    return ListView.builder(
                                        itemCount: data.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          TaskModel task = TaskModel.fromJson(
                                              data[index].data()
                                                  as Map<String, dynamic>);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TaskDetailsScreen(
                                                              goalID:
                                                                  task.goalId!,
                                                              taskID: task
                                                                  .taskId!))),
                                              child: Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                  ),

                                                  // border
                                                  border: Border(
                                                      left: BorderSide(
                                                    color: Color(int.parse(
                                                        '0xff${task.taskColor}')),
                                                    width: 15,
                                                  )),
                                                ),
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                            color: Colors.grey),
                                                        right: BorderSide(
                                                            color: Colors.grey),
                                                        bottom: BorderSide(
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                task.taskTitle
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                        color: AppColors
                                                                            .secondaryTextColor),
                                                              ),
                                                              const Spacer(),
                                                              Text(
                                                                task.endDate
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primaryTextColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 10),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                task.goalName
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primaryTextColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ) // end upcoming task container
                                                    ),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  return LoadingWidget();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const Center(child: LoadingWidget());
            }));
  }
}
