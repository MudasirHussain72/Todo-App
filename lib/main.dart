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
import 'package:todo_app/view_model/controller/login/login_controller.dart';
import 'package:todo_app/view_model/controller/signup/signup_controller.dart';

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
  runApp(MyApp());
  // DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => SignupController()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordController()),
        ChangeNotifierProvider(create: (_) => CreateGoalController()),
      ],
      child: MaterialApp(
        title: 'TODOER',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        initialRoute: RouteName.splashView,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
