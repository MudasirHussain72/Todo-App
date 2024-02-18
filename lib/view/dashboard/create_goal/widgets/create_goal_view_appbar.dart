import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class CreateGoalViewAppbar extends StatefulWidget
    implements PreferredSizeWidget {
  CreateGoalViewAppbar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CreateGoalViewAppbarState createState() => _CreateGoalViewAppbarState();
}

class _CreateGoalViewAppbarState extends State<CreateGoalViewAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('New Goal'),
      actions: [
        Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Consumer<CreateGoalController>(
              builder: (context, provider, child) => GestureDetector(
                onTap: () {
                  if (provider.goalNameController.text.length < 2) {
                    Utils.flushBarErrorMessage('Enter goal name', context);
                  } else if (provider.goalDescController.text.length < 2) {
                    Utils.flushBarErrorMessage(
                        'Enter goal description', context);
                  } else if (provider.selectedGoalColorCode == '') {
                    Utils.flushBarErrorMessage(
                        'Select your Goal Color', context);
                  } else if (provider.tasksList.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Add your tasks to create your goal', context);
                  } else {
                    provider
                        .createGoal(context)
                        .then((value) => provider.setNewValueToGoalId());
                  }
                },
                child: Text('save',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18)),
              ),
            ))
      ],
    );
  }
}
