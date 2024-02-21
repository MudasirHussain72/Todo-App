import 'package:flutter/material.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/utils/utils.dart';

class ContactUsTermsPoliciesWidget extends StatelessWidget {
  const ContactUsTermsPoliciesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.toastMessage('We will update it soon'),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        height: 265,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "What's new",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.secondaryTextColor,
                  size: 14,
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "FAQs / Contact us",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.secondaryTextColor,
                  size: 14,
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Community Guidelines",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.secondaryTextColor,
                  size: 14,
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Terms of use",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.secondaryTextColor,
                  size: 14,
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Privacy policies",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.secondaryTextColor,
                  size: 14,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
