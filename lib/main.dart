import 'package:flutter/material.dart';
import 'package:pm_flutter/resources/colors/main_colors.dart';
import 'package:pm_flutter/resources/styles/main_styles.dart';
import 'package:pm_flutter/view/home/home.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'resources/app_strings.dart';
import 'route.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: route.controller,
      home: MyAppPage(),
    );
  }
}

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashScreenView(
            navigateRoute: Home(),
            duration: 3000,
            text: AppStrings.appName.toUpperCase(),
            textType: TextType.ColorizeAnimationText,
            textStyle: MainStyles.mainAppNameTextStyle,
            colors: MainColors.appNameTextColor),
      ),
    );
  }
}
