import 'package:flutter/material.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/choose_goal_widget.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/create_goal_view_appbar.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/create_task_choose_color_widget.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/enter_task_name_widget.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/select_end_date_widget.dart';
import 'package:todo_app/view/dashboard/new_task/widgets/select_start_date_widget.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateTaskAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const EnterTaskNameWidget(),
                  const SizedBox(height: 10),
                  const SelectStartDateWidget(),
                  const SizedBox(height: 10),
                  const SelectEndDateWidget(),
                  ChooseGoalWidget(),
                  const CreateTaskChooseColorWidget(),
                  // const AddLinksWidget(),
                  // const ShowAddedLinksWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
