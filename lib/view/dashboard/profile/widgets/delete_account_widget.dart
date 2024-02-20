import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/view_model/controller/profile/profile_controller.dart';

class DeactiveAccountWidget extends StatelessWidget {
  const DeactiveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 31, vertical: 20),
      child: Consumer<ProfileController>(
        builder: (context, value, child) => RoundButton(
            title: 'Delete account',
            buttonColor: Colors.red.withOpacity(0.1),
            textColor: Colors.red,
            onPress: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    // <-- SEE HERE
                    title: const Text('Delete account'),
                    content: const SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text('Are you sure want to delete account?'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('No'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Yes'),
                        onPressed: () {
                          value.deleteAccount(context);
                        },
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
