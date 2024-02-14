import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';

class CreateTaskChooseColorWidget extends StatelessWidget {
  const CreateTaskChooseColorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialColorPicker(
      onColorChange: (Color color) {
        debugPrint('Color $color');
      },
      onMainColorChange: (ColorSwatch? color) {
        debugPrint('Color $color');
        String hexValue = color!.value.toRadixString(16).substring(2);
        var provider =
            Provider.of<CreateGoalController>(context, listen: false);
        provider.setTaskColorCode(hexValue);
      },
      circleSize: 32,
      selectedColor: Colors.purple,
      allowShades: false,
      colors: const [
        Colors.purple,
        Colors.lightGreen,
        Colors.red,
        Colors.yellow,
      ],
    );
  }
}
