import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/theme/fonts.dart';

class InputTextField extends StatelessWidget {
  const InputTextField(
      {Key? key,
      required this.myController,
      required this.focusNode,
      required this.onFiledSubmittedValue,
      required this.keyBoardType,
      this.obscureText = false,
      required this.hint,
      this.enable = true,
      this.maxLines = 1,
      required this.onValidator,
      this.autoFocus = false})
      : super(key: key);

  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator<String> onValidator;
  final int maxLines;
  final TextInputType keyBoardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        obscureText: obscureText,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyBoardType,
        maxLines: maxLines,
        cursorColor: AppColors.inputTextBorderColor,
        style:
            Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 16),
        // style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 16, color: AppColors.hintColor,fontFamily: AppFonts.poppinsRegular ),
        decoration: InputDecoration(
          hintText: hint,
          enabled: enable,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontSize: 16,
              color: AppColors.hintColor,
              fontFamily: AppFonts.poppinsRegular),
          errorStyle: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontSize: 14, color: AppColors.alertColor),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.slate400, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.slate400, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.slateColor.withOpacity(.4), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.slate400, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.slate400, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
