import 'package:Product/ui/view/authentication/enter_number.dart';
import 'package:Product/ui/view/homes_creens/screen1.dart';
import 'package:flutter/material.dart';
import 'package:Product/ui/view/splash_screen_view.dart';
import 'package:Product/ui/view/suggest_view.dart';
import 'package:Product/ui/view/authentication/signup_view.dart';
import 'package:Product/ui/view/authentication/landing_view.dart';

class NavigationRouter {
  static const String splashScreen = "splashScreen";
  static const String signUpScreen = "signUpScreen";
  static const String landingScreen = "landingScreen";
  static const String signInScreen = "signInScreen";
  static const String suggestScreen = "suggestScreen";
  static const String enterNumberScreen = "EnterNumberScreen";
  static const String screen1 = "Screen1";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreenView(),
        );
      case signUpScreen:
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
        );
      case landingScreen:
        return MaterialPageRoute(
          builder: (_) => LandingView(),
        );
      case suggestScreen:
        return MaterialPageRoute(
          builder: (_) => SuggestView(),
        );
      case enterNumberScreen:
        return MaterialPageRoute(
          builder: (_) => EnterNumber(),
        );
      case screen1:
        return MaterialPageRoute(builder: (_)=>Screen1());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text("No route defined for ${settings.name}"),
            ),
          ),
        );
    }
  }
}
