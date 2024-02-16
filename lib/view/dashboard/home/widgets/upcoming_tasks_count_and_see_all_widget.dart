import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/component/shimmer_widget.dart';
import 'package:todo_app/view/dashboard/home/widgets/show_all_todays_upcoming_tasks_screen.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';

class UpcomingTaskCountAndSeeAllWidget extends StatelessWidget {
  const UpcomingTaskCountAndSeeAllWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<HomeController>(builder: (context, value, child) {
      return value.fetchAndSetTasksCountLoading
          ? Center(child: ShimmerWidget(width: size.width * 0.9, height: 40))
          : SizedBox(
              width: size.width * 0.9,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  SizedBox(
                    width: size.width * 0.9,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.6,
                          child: const Text(
                            'Upcoming task for today',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: TodayUpcomingTasksScreen(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]!),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: size.width * 0.36,
                    child: Text(
                      value.upcomingTasksCount.toString(),
                      style: TextStyle(
                          fontSize: 16, color: Colors.deepPurpleAccent),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
