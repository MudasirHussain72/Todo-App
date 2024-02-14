import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class SelectStartDateWidget extends StatefulWidget {
  const SelectStartDateWidget({super.key});

  @override
  State<SelectStartDateWidget> createState() => _SelectStartDateWidgetState();
}

class _SelectStartDateWidgetState extends State<SelectStartDateWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: Consumer<CreateGoalController>(
        builder: (context, value, child) => GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 0)),
                    lastDate: DateTime(2101))
                .then((dateAndTime) {
              value.startDateController.text =
                  '${dateAndTime!.month}/${dateAndTime.day}/${dateAndTime.year}';
              setState(() {});
            });
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1.0,
                  color: AppColors.slate400,
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    value.startDateController.text,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.grey[400],
                    size: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
