import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view_model/controller/profile/profile_controller.dart';

class PickImageDailog extends StatelessWidget {
  const PickImageDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              ProfileController().pickImage(context, ImageSource.camera);
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.camera,
              color: AppColors.primaryIconColor,
            ),
            title: const Text('Camera'),
          ),
          ListTile(
            onTap: () {
              ProfileController().pickImage(context, ImageSource.gallery);
              Navigator.pop(context);
            },
            leading: const Icon(
              Icons.image,
              color: AppColors.primaryIconColor,
            ),
            title: const Text('Gallery'),
          )
        ],
      ),
    );
  }
}
