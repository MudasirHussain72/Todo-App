import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/loading_widget.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/add_tasks_widget.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/choose_color_widget.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/create_goal_view_appbar.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/enter_goal_description_widget.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/enter_goal_name_widget.dart';
import 'package:todo_app/view/dashboard/create_goal/widgets/show_added_tasks_widget.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class CreateGoalView extends StatefulWidget {
  const CreateGoalView({super.key});

  @override
  State<CreateGoalView> createState() => _CreateGoalViewState();
}

class _CreateGoalViewState extends State<CreateGoalView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CreateGoalViewAppbar(),
      body: Consumer<CreateGoalController>(
        builder: (context, value, child) => value.loading
            ? const Center(child: LoadingWidget())
            : const SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        EnterGoalNameWidget(),
                        EnterGoaDescriptionWidget(),
                        ChooseColorWidget(),
                        AddTasksWidget(),
                        ShowAddedTasksWidget(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
