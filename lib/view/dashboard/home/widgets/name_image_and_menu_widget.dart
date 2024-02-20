import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/network_image_widget.dart';
import 'package:todo_app/res/component/shimmer_widget.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/dashboard/profile/profile_view.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class NameImageAndMenuWidget extends StatelessWidget {
  const NameImageAndMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: ShimmerWidget(width: size.width * 0.9, height: 50));
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            String fullName = userData['name'];

            String profileImage = userData['profileImage'];

            return SizedBox(
              width: size.width * 0.9,
              child: Row(
                children: [
                  NetworkImageWidget(
                    height: 50,
                    width: 50,
                    borderRadius: 50,
                    imageUrl: profileImage.toString(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, ${fullName.toString()}!',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: AppColors.primaryTextColor),
                        ),
                        Text(
                          Utils().showMorningMessage(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 18,
                                  color: AppColors.secondaryTextColor),
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
                        screen: const ProfileView(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
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
          } else {
            return const Center(
              child: Text('No data found'),
            );
          }
        }
      },
    );
  }
}
