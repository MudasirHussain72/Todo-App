import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/input_text_field.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

// ignore: must_be_immutable
class ChooseGoalWidget extends StatelessWidget {
  ChooseGoalWidget({super.key});
  List<Goal> list = [
    const Goal('Other', Icons.radio_button_unchecked_outlined),
    const Goal('Developer', Icons.developer_mode),
    const Goal('Designer', Icons.design_services),
    const Goal('Consultant', Icons.account_balance),
    const Goal('Student', Icons.school),
    const Goal('Teacher', Icons.school),
  ];
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(height: 20),
    //     Text(
    //       'Task Categories',
    //       style: Theme.of(context)
    //           .textTheme
    //           .bodySmall!
    //           .copyWith(fontSize: 16, color: AppColors.secondaryTextColor),
    //     ),
    //     const SizedBox(height: 6),
    //     SizedBox(
    //       width: size.width * 0.9,
    //       child: CustomDropdown<Goal>.search(
    //         decoration: CustomDropdownDecoration(
    //             closedFillColor: Colors.transparent,
    //             closedBorder: Border.all(color: AppColors.slate400),
    //             closedBorderRadius: BorderRadius.circular(8)),
    //         hintText: 'Choose Categories',
    //         items: list,
    //         excludeSelected: false,
    //         onChanged: (value) {
    //           var provider =
    //               Provider.of<CreateGoalController>(context, listen: false);
    //           provider.setGoalType(value.name);
    //           debugPrint('changing value to: $value');
    //         },
    //       ),
    //     ),
    //     const SizedBox(height: 20),
    //   ],
    // );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:
          Consumer<CreateGoalController>(builder: (context, provider, child) {
        return InputTextField(
          maxLines: 10,
          myController: provider.taskdescController,
          focusNode: provider.taskdescFocusNode,
          onFiledSubmittedValue: (newValue) {},
          keyBoardType: TextInputType.text,
          hint: 'Enter task description',
          onValidator: (value) {
            return null;
          },
        );
      }),
    );
  }
}

class Goal with CustomDropdownListFilter {
  final String name;
  final IconData icon;
  const Goal(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
