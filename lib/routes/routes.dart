import 'package:flutter/widgets.dart';
import 'package:travelink_app/screens/wellcome_screen.dart';
import 'package:travelink_app/screens/Login/Login_Page.dart';
import 'package:travelink_app/screens/Home/root.dart';

final Map<String, WidgetBuilder> routes = {
  WellcomeScreen.routeName: (context) => const WellcomeScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  RootApp.routeName: (context) => const RootApp(),
};
