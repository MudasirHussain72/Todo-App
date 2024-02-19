import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/res/theme/light_theme.dart';
import 'package:todo_app/utils/routes/route_name.dart';
import 'package:todo_app/utils/routes/routes.dart';
import 'package:todo_app/view_model/controller/create_goal/create_goal_controller.dart';
import 'package:todo_app/view_model/controller/forgot_password/forgot_password_controller.dart';
import 'package:todo_app/view_model/controller/goal_detail/goal_detail_controller.dart';
import 'package:todo_app/view_model/controller/home/home_controller.dart';
import 'package:todo_app/view_model/controller/login/login_controller.dart';
import 'package:todo_app/view_model/controller/profile/profile_controller.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';
import 'package:device_preview/device_preview.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //setting app orientation in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(DevicePreview(
    isToolbarVisible: false,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordController()),
        ChangeNotifierProvider(create: (_) => CreateGoalController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => EditGoaController()),
      ],
      child: MaterialApp(
        title: 'TODOER',
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: RouteName.splashView,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
