import 'package:flutter/material.dart';
import 'package:todo_app/view/dashboard/home/widgets/goals_progress_text_and_see_all_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/list_goals_in_horizontal_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/list_todays_upcoming_tasks_animated_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/name_image_and_menu_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/show_today_progress_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/upcoming_tasks_count_and_see_all_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const NameImageAndMenuWidget(),
                const SizedBox(height: 40),
                const ShowTodayProgressWidget(),
                const SizedBox(height: 30),
                const UpcomingTaskCountAndSeeAllWidget(),
                const SizedBox(height: 20),
                ListTodaysUpcomingTasksAnimatedWidget(),
                const SizedBox(height: 20),
                const GoalsProgressTextAndSeeAllWidget(),
                const SizedBox(height: 20),
                ListGoalsInHorizontalWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
