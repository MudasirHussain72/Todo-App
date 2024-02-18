import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/logout_button.dart';
import 'package:todo_app/view/dashboard/profile/widgets/contact_us_terms_policies.dart';
import 'package:todo_app/view/dashboard/profile/widgets/profile_picture_widget.dart';
import 'package:todo_app/view_model/controller/profile/profile_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('User');
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: ref
                  .where('uid', isEqualTo: SessionController().user.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfilePictureWidget(snapshot: snapshot),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 40,
                          child: Consumer<ProfileController>(
                            builder: (context, value, child) => InkWell(
                              onTap: () {
                                // value.shownameDialogAlert(
                                //     context, SessionController().name.toString());
                                value
                                    .updateDialogAlert(
                                        context,
                                        SessionController()
                                            .user
                                            .name
                                            .toString(),
                                        'name',
                                        TextInputType.name)
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Full name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 14, height: 2),
                                  ),
                                  Text(
                                    SessionController().user.name.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Divider(thickness: 1),
                        ContactUsTermsPoliciesWidget(),
                        LogoutButtonWidget(),
                      ],
                    ),
                  );
                } else {
                  return Center(
                      child: Text(
                    'Something went wrong',
                    style: Theme.of(context).textTheme.titleMedium,
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
