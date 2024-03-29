import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view/dashboard/calender/calendar_view.dart';
import 'package:todo_app/view/dashboard/create_goal/create_goal_view.dart';
import 'package:todo_app/view/dashboard/home/home_view.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/services/session_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with WidgetsBindingObserver {
  final controler = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScren() {
    return [
      const HomeView(),
      const CreateGoalView(),
      CalendarView(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/house_fill.svg',
          height: 26,
          width: 26,
          // color: Colors.white,
          color: AppColors.primaryButtonColor,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/house.svg',
          height: 26,
          width: 26,
          // color: Colors.white,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        activeColorPrimary: AppColors.primaryButtonColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.primaryColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.add_circle,
          size: 40,
          color: AppColors.primaryButtonColor,
        ),
        activeColorPrimary: AppColors.primaryButtonColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.primaryColor,
        inactiveIcon: Icon(
          CupertinoIcons.plus_circled,
          size: 40,
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          'assets/icons/calendar_fill.svg',
          height: 26,
          width: 26,
          // color: Colors.white,
          color: AppColors.primaryButtonColor,
        ),
        inactiveIcon: SvgPicture.asset(
          'assets/icons/calendar.svg',
          height: 26,
          width: 26,
          // color: Colors.white,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        activeColorPrimary: AppColors.primaryButtonColor,
        inactiveColorPrimary: AppColors.whiteColor,
        activeColorSecondary: AppColors.primaryColor,
      ),
    ];
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    final homeViewController =
        Provider.of<HomeController>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeViewController.fetchAndSetTasksCount();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid.toString())
          .update({'onlineStatus': 'online'});
    } else {
      FirebaseFirestore.instance
          .collection('User')
          .doc(SessionController().user.uid.toString())
          .update({
        'onlineStatus': DateTime.now().microsecondsSinceEpoch.toString()
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScren(),
      items: _navBarItem(),
      controller: controler,
      // backgroundColor: Colors.grey.shade900,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: AppColors.iconBlueColor,
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
