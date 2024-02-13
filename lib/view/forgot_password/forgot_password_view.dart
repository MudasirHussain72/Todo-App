import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/round_button.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view/forgot_password/widgets/forgot_password_email.dart';
import 'package:todo_app/view_model/controller/forgot_password/forgot_password_controller.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              RichText(
                text: TextSpan(
                  text: 'Forgot Password',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(color: Colors.orange, fontSize: 22),
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            ' Enter Email We Will Send You Email To Recover Your Password',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.black, fontSize: 22)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ForgotPasswordEmailInputTextFiled(),
              const SizedBox(height: 50),
              Consumer<ForgotPasswordController>(builder: (context, provider, child) {
                return RoundButton(
                  title: 'Continue',
                  loading: provider.loading,
                  onPress: () {
                    if (provider.forgotPasswordEmailController.text.isEmpty) {
                      Utils.flushBarErrorMessage('Enter email', context);
                    } else {
                      provider.forgotPassword(context);
                    }
                  },
                  borderRadius: 12,
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
