import 'package:flutter/material.dart';
import 'package:todo_app/model/goal_model.dart';
import 'package:todo_app/model/task_model.dart';
import 'package:todo_app/view/dashboard/home/task_detail_screen.dart';

// ignore: must_be_immutable
class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  List<TaskModel> taskList = [
    TaskModel(
      'English C1',
      '093947',
      '2/14/2024',
      'Developer',
      ['https://youtube.com', 'https://youtube.com' 'https://youtube.com'],
      '2/14/2024',
    ),
    TaskModel(
      'UI/UX Design',
      '093947',
      '2/14/2024',
      'Developer',
      ['https://youtube.com', 'https://youtube.com' 'https://youtube.com'],
      '2/14/2024',
    ),
    TaskModel(
      'Healthy Training',
      '093947',
      '2/14/2024',
      'Developer',
      ['https://youtube.com', 'https://youtube.com' 'https://youtube.com'],
      '2/14/2024',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Calendar',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.edit,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 200),
                const Text(
                  'Tasks', // No tasks for today depend on task list
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: size.width * 0.9,
                  child: ListView.builder(
                      itemCount: taskList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TaskDetailsScreen(
                                        taskDetail: taskList[index])),
                              );
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),

                                // border
                                border: Border(
                                    left: BorderSide(
                                  color: Color(0xff +
                                      int.parse(taskList[index].taskColor!)),
                                  width: 15,
                                )),
                              ),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: Colors.grey),
                                      right: BorderSide(color: Colors.grey),
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              taskList[index]
                                                  .taskTitle
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            const Spacer(),
                                            Text(
                                              taskList[index]
                                                  .endDate
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              // taskList[index]
                                              // .taskSubTitle
                                              // .toString(),
                                              'English Lesson',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
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
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
