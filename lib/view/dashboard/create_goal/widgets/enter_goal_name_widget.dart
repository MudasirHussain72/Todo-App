import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class EnterGoalNameWidget extends StatelessWidget {
  const EnterGoalNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Consumer<CreateGoalController>(builder: (context, provider, child) {
        return InputTextField(
          myController: provider.goalNameController,
          focusNode: provider.goalNameFocusNode,
          onFiledSubmittedValue: (newValue) {
            Utils.fieldFocus(
                context, provider.goalNameFocusNode, provider.goalDescFocusNode);
          },
          keyBoardType: TextInputType.text,
          hint: 'Enter goal name',
          onValidator: (value) {
            return null;
          },
        );
      }),
    );
  }
}
