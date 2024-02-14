import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class ShowAddedLinksWidget extends StatelessWidget {
  const ShowAddedLinksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height / 2,
        child: Consumer<CreateGoalController>(
            builder: (context, value, child) => ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.tasksLinks.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(value.tasksLinks[index].toString()),
                  ),
                )));
  }
}
