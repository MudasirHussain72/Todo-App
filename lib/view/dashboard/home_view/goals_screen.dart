import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:todo_app/view/dashboard/home_view/goal_detail_screen.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {

  List<GoalsModel> goalList = [
    GoalsModel('UI/UX Design', '10/20', '50', '073763'),
    GoalsModel('English C1', '14/120', '11', '004c00'),
    GoalsModel('Healthy Training', '10/20', '50', 'cc3333'),
    GoalsModel('20 Books in a year', '14/120', '11', 'a68083'),
    GoalsModel('Travling Goals', '10/20', '50', 'f1c1af'),
    GoalsModel('Healthy Eating', '14/120', '11', '9f8170')
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
          appBar: AppBar(
        title:  const Text(
          'Goals',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w800
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  width: size.width * 0.9,
                  child: ListView.builder(
                    itemCount: goalList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GoalsDetailScreen(goalsData: goalList[index])),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(int.parse('0xff${goalList[index].goalColor}')).withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        goalList[index].goalTitle.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.edit_outlined,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                                  child: Text(
                                    goalList[index].goalCompleted.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                                  child: LinearPercentIndicator(
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: double.parse(goalList[index].percentage.toString()) / 100,
                                    backgroundColor: Colors.grey[200]!,
                                    curve: Curves.easeInOut,
                                    barRadius: const Radius.circular(20),
                                    progressColor: Color(int.parse('0xff${goalList[index].goalColor}')),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      
                      );
                    }
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GoalsModel {
  String? goalTitle;
  String? goalCompleted;
  String? percentage;
  String? goalColor;

  GoalsModel(this.goalTitle, this.goalCompleted, this.percentage, this.goalColor);
}