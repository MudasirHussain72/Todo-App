import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/dashboard/home/goals_screen.dart';

class ListTodaysUpcomingTasksAnimatedWidget extends StatefulWidget {
  ListTodaysUpcomingTasksAnimatedWidget({super.key});

  @override
  State<ListTodaysUpcomingTasksAnimatedWidget> createState() =>
      _ListTodaysUpcomingTasksAnimatedWidgetState();
}

class _ListTodaysUpcomingTasksAnimatedWidgetState
    extends State<ListTodaysUpcomingTasksAnimatedWidget> {
  List taskList = [
    {
      'taskTitle': 'English Lession',
      'subTitle': 'English C1',
      'taskTime': 'from 7 to 7:50 pm',
      'color': Colors.purple
    },
    {
      'taskTitle': 'TXR Training',
      'subTitle': 'Healthy Training',
      'taskTime': 'at 9 pm',
      'color': Colors.orange
    },
  ];
  bool isExpandedContainer = false;
  int animatedContainerIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
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
                  debugPrint('index: $index');
                  setState(() {
                    if (animatedContainerIndex == index &&
                        isExpandedContainer) {
                      // Navigate to new screen without closing the expanded container
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GoalsScreen(),
                        ),
                      );
                    } else {
                      isExpandedContainer = true;
                      animatedContainerIndex = index;
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  height: animatedContainerIndex == index ? 260 : 100,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: isExpandedContainer
                        ? taskList[index]['color']
                        : Colors.transparent,
                    borderRadius: !isExpandedContainer
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          )
                        : BorderRadius.circular(12),

                    // border
                    border: Border(
                      left: !isExpandedContainer
                          ? BorderSide(
                              color: taskList[index]['color'],
                              width: 15,
                            )
                          : const BorderSide(color: Colors.transparent),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: !isExpandedContainer
                            ? const BorderSide(color: Colors.grey)
                            : BorderSide.none,
                        right: !isExpandedContainer
                            ? const BorderSide(color: Colors.grey)
                            : BorderSide.none,
                        bottom: !isExpandedContainer
                            ? const BorderSide(color: Colors.grey)
                            : BorderSide.none,
                      ),
                    ),
                    child: !isExpandedContainer
                        ? Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      taskList[index]['taskTitle'].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const Spacer(),
                                    Text(
                                      taskList[index]['taskTime'].toString(),
                                      style: const TextStyle(
                                          fontSize: 17, color: Colors.grey),
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
                                      taskList[index]['subTitle'].toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : SingleChildScrollView(
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
                                      const Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Text(
                                          '04:00 PM',
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            taskList[index]['taskTitle']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            taskList[index]['subTitle']
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                      const SizedBox(width: 20),
                                      const Icon(
                                        Icons.remove_red_eye_rounded,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    ],
                                  ),
                                ),

                                // Action slider
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ActionSlider.standard(
                                    backgroundColor: taskList[index]['color']
                                        [800],
                                    toggleColor: taskList[index]['color'][600],
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
            );
          }),
    );
  }
}
