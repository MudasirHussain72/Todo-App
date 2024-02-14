import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_app/res/component/logout_button.dart';
import 'package:todo_app/res/component/network_image_widget.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/dashboard/home/goal_detail_screen.dart';
import 'package:todo_app/view/dashboard/home/goals_screen.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class TodoHomeScreen extends StatefulWidget {
  TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
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
  List<GoalsModel> goalList = [
    GoalsModel('English C1', '14/120', '11', '004c00'),
    GoalsModel('English C1', '14/120', '11', '004c00'),
  ];

  bool isExpandedContainer = false;
  int animatedContainerIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final messages = Utils().showProgressMessages(1, 10);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // image container
                SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    children: [
                      NetworkImageWidget(
                          height: 50,
                          width: 50,
                          imageUrl:
                              SessionController().user.profileImage.toString()),

                      // name column
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${SessionController().user.name.toString()}',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.grey),
                            ),
                            Text(
                              Utils().showMorningMessage(context),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),
                      // right icon
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Scaffold(
                                    body: Center(child: LogoutButtonWidget())),
                              ));
                        },
                        icon: const Icon(
                          Icons.menu,
                          size: 35,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                // Progress container
                Container(
                  height: 200,
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey[350]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1/10',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  messages[0],
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  messages[1],
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Today progress',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 20.0,
                          animationDuration: 2500,
                          percent: double.parse('${1 / 10 * 1}'),
                          backgroundColor: Colors.grey[200]!,
                          curve: Curves.easeInOut,
                          barRadius: const Radius.circular(20),
                          progressColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ), // end progress bar container
                ),
                const SizedBox(height: 30),

                // Upcoming task
                SizedBox(
                  width: size.width * 0.9,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SizedBox(
                        width: size.width * 0.9,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width * 0.6,
                              child: const Text(
                                'Upcoming task for today',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[700]!),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: size.width * 0.36,
                        child: const Text(
                          '7',
                          style: TextStyle(
                              fontSize: 16, color: Colors.deepPurpleAccent),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Task list
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
                              debugPrint('index: $index');
                              setState(() {
                                if (animatedContainerIndex == index &&
                                    isExpandedContainer) {
                                  // Navigate to new screen without closing the expanded container
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GoalsScreen(),
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
                              height:
                                  animatedContainerIndex == index ? 260 : 100,
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
                                      : const BorderSide(
                                          color: Colors.transparent),
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
                                                  taskList[index]['taskTitle']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const Spacer(),
                                                Text(
                                                  taskList[index]['taskTime']
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
                                                  taskList[index]['subTitle']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : SingleChildScrollView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        child: Column(
                                          children: [
                                            // Time and edit row
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.timer_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 5),
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        taskList[index]
                                                                ['taskTitle']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                        taskList[index]
                                                                ['subTitle']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 25,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                  const SizedBox(width: 20),
                                                  const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    color: Colors.white,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // Action slider
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: ActionSlider.standard(
                                                backgroundColor: taskList[index]
                                                    ['color'][800],
                                                toggleColor: taskList[index]
                                                    ['color'][600],
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
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                action: (controller) async {
                                                  controller
                                                      .loading(); //starts loading animation
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 3));
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
                ),

                const SizedBox(height: 20),

                // Goals progress
                SizedBox(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width * 0.48,
                        child: const Text(
                          'Goals Progress',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GoalsScreen(),
                              ));
                        },
                        child: Text(
                          'See all',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]!),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Goals progress horizontal listview
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 110,
                    child: ListView.builder(
                        itemCount: goalList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GoalsDetailScreen(
                                            goalsData: goalList[index],
                                          ))),
                              child: Container(
                                width: size.width * 0.7,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.grey)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 12),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  goalList[index]
                                                      .goalTitle
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  goalList[index]
                                                      .goalCompleted
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: CircularPercentIndicator(
                                              radius: 40.0,
                                              lineWidth: 8.0,
                                              percent: double.parse(
                                                      goalList[index]
                                                          .percentage
                                                          .toString()) /
                                                  100,
                                              center: Text(
                                                '${goalList[index].percentage.toString()}%',
                                              ),
                                              progressColor: Color(int.parse(
                                                  '0xff${goalList[index].goalColor}')),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
