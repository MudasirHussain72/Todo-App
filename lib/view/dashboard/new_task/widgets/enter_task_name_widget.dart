import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class EnterTaskNameWidget extends StatelessWidget {
  const EnterTaskNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child:
          Consumer<CreateGoalController>(builder: (context, provider, child) {
        return InputTextField(
          myController: provider.taskNameController,
          focusNode: provider.taskNameFocusNode,
          onFiledSubmittedValue: (newValue) {},
          keyBoardType: TextInputType.text,
          hint: 'Enter task name',
          onValidator: (value) {
            return null;
          },
        );
      }),
    );
  }
}
