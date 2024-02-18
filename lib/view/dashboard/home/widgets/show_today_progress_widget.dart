import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/component/shimmer_widget.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';

class ShowTodayProgressWidget extends StatelessWidget {
  const ShowTodayProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<HomeController>(builder: (context, value, child) {
      final messages = Utils().showProgressMessages(
          value.completedTasksCount, value.totalTasksCount);
      return value.fetchAndSetTasksCountLoading
              ? Center(
                  child: ShimmerWidget(width: size.width * 0.9, height: 160))
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[350]!)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${value.completedTasksCount}/${value.totalTasksCount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 30,
                                      color: AppColors.secondaryTextColor),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  messages[0],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 18,
                                          color: AppColors.secondaryTextColor),
                                ),
                                Text(
                                  messages[1],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          fontSize: 18,
                                          color: AppColors.secondaryTextColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Today progress',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 18,
                                  color: AppColors.secondaryTextColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2500,
                          percent: value.totalTasksCount != 0
                              ? value.completedTasksCount /
                                  value.totalTasksCount
                              : 0, // Check if totalTasksCount is not zero
                          backgroundColor: Colors.grey[200]!,
                          curve: Curves.easeInOut,
                          barRadius: const Radius.circular(20),
                          progressColor: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                ) // end progress bar container
          ;
    });
  }
}
