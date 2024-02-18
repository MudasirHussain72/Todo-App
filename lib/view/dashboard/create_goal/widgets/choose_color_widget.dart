import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class ChooseColorWidget extends StatelessWidget {
  const ChooseColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Text(
            'Choose Color',
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 18, color: AppColors.secondaryTextColor),
          ),
          const SizedBox(height: 10),
          MaterialColorPicker(
            onColorChange: (Color color) {
              debugPrint('Color $color');
            },
            onMainColorChange: (ColorSwatch? color) {
              debugPrint('Color $color');
              String hexValue = color!.value.toRadixString(16).substring(2);
              var provider =
                  Provider.of<CreateGoalController>(context, listen: false);
              provider.setGoalColorCode(hexValue);
            },
            selectedColor: Colors.lightGreen,
            allowShades: false,
            colors: const [
              Colors.lightGreen,
              Colors.red,
              Colors.purple,
              Colors.yellow,
            ],
            circleSize: 32,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
