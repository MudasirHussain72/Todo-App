import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class EnterGoaDescriptionWidget extends StatelessWidget {
  const EnterGoaDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateGoalController>(builder: (context, provider, child) {
      return InputTextField(
        maxLines: 10,
        myController: provider.goalDescController,
        focusNode: provider.goalDescFocusNode,
        onFiledSubmittedValue: (newValue) {},
        keyBoardType: TextInputType.text,
        hint: 'Enter goal description',
        onValidator: (value) {
          return null;
        },
      );
    });
  }
}
