import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/network_image_widget.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/dashboard/profile/profile_view.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class NameImageAndMenuWidget extends StatelessWidget {
  const NameImageAndMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.9,
      child: Row(
        children: [
          NetworkImageWidget(
            height: 50,
            width: 50,
            borderRadius: 50,
            imageUrl: SessionController().user.profileImage.toString(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello, ${SessionController().user.name.toString()}!',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: AppColors.primaryTextColor),
                ),
                Text(
                  Utils().showMorningMessage(context),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18, color: AppColors.secondaryTextColor),
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: ProfileView(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            icon: const Icon(
              Icons.menu,
              // size: 35,
            ),
          )
        ],
      ),
    );
  }
}
